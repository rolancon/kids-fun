#charset "us-ascii"
/*

! =================================================================== !
!  Cloak of Darkness - a simple demonstration of Interactive Fiction
!     This version for Tads-3 written by Steve Breslin on 10Nov04
! =================================================================== !

The author can be reached at versim@hotmail.com

This is a part of Roger Firth's larger "Cloak of Darkness" project,
which you can find at:

http://www.firthworks.com/roger/cloak/index.html

Because the specifications of this game are simplistic by design, this
implementation is not intended to reflect the power of Tads-3; instead,
we simply give a basic picture of how Tads-3 code looks and operates.
You can find more information about Tads-3 at:

http://www.tads.org/t3dl.htm

Thanks to Dan Schmidt for the original Tads-3 contribution to this
project, and Nikos Chantziaras, Antti Markus, and Matthew Herberg for
revising and maintaining it. Thanks also to members of the Tads-3
v-space discussion group and others, for reviewing this work.

*/

///////////////////////////////////////////////////////////////////////

/*
* We include the main header for the standard TADS 3 adventure
* library, and also include the US English definitions, since this
* game is written in English.
*/
#include <adv3.h>
#include <en_us.h>

/*
* In the following, we provide information about our game credits and
* version information. It is not necessary to provide this information,
* but it is normal and "good form."
*
* Like almost all Tads-3 code, the information here is encapsulated in
* an "object," which we here call "versionInfo." This being the first
* object definition in this demonstration, let's take a brief moment to
* introduce the code structure of Tads-3:
*
* Objects define some properties and processes themselves, and inherit
* other properties and processes from parent objects or "classes."
* The first line of this definition indicates that this versionInfo
* object inherits from the class GameID. The rest of this object
* definition sets some of the object's properties equal to some values.
*/

versionInfo: GameID
    name = 'Cloak of Darkness'
    byline = 'by Steve Breslin'
    htmlByline = 'by <a href="mailto:versim@hotmail.com">
                  Steve Breslin</a>'
    version = '1.0'
    authorEmail = 'Steve Breslin <versim@hotmail.com>'
    desc = 'This is a demonstration of Tads-3 code, towards the purpose
            of comparison with implementations of this game on other IF
            development platforms. Please see Roger Firth\'s
            webpage for information on this larger project:
            http://www.firthworks.com/roger/cloak/index.html'
    htmlDesc = 'This is a demonstration of Tads-3 code, towards the
            purpose of comparison with implementations of this game on
            other IF development platforms. Please see Roger Firth\'s
            webpage for information on this larger project:
            <a href="http://www.firthworks.com/roger/cloak/index.html">
            http://www.firthworks.com/roger/cloak/index.html</a>'
    showAbout = "<<desc>>"
    showCredit = "Steve Breslin wrote this demonstration, but Roger
                 Firth gets the principal credit for this project.
                 (Type <a href=\"about\">ABOUT</a> for more details.)\n
                 Thanks to Dan Schmidt for the original Tads-3
                 contribution to this project, and Nikos Chantziaras,
                 Antti Markus, and Matthew Herberg for revising and
                 maintaining it. Thanks also to members of the Tads-3
                 v-space discussion group and others, for reviewing
                 this work.\b
                 And thanks especially for your interest."

; // a semicolon closes the object definition.

/*
* The "gameMain" object lets us set the initial player character and
* control the game's startup procedure.
*
* This definition sets the property initialPlayerChar equal to another
* object, me, defined below; also we define a process or "method" -- a
* function defined by the object -- called showIntro. The showIntro
* method prints the introductory text of the game.
*/
gameMain: GameMainDef
    /* the initial player character is 'me' */
    initialPlayerChar = me

    /* This is the introductory text printed before the first "look
     * around" at the beginning of the game.
     */
    showIntro()
    {
        "Hurrying through the rainswept November night, you're glad to
        see the bright lights of the Opera House. It's surprising that
        there aren't more people about but, hey, what do you expect in
        a cheap demo game...?
        <p><b>Cloak of Darkness</b>\n
        A basic IF demonstration.\n
        Version <<versionInfo.version>>
        <\p>";
    }
;

/*
* The preceding two objects are abstract programmatic objects. The
* next object, on the other hand, is our first game object. It
* represents a room in the game, which happens to be the player
* character's initial location.
*
* Room objects define two strings: (1) the 'name' of the room, and
* (2) the "description" of the room.
*
* We could define these properties explicitly, but instead we use the
* Room template for convenience (so we can just type out the strings
* in the correct order, which are then automatically associated with
* the corresponding properties -- for easy convenience).
*/
foyer: Room 'Foyer of the Opera House'
    "You are standing in a spacious hall, splendidly decorated in red
    and gold, with glittering chandeliers overhead. The entrance from
    the street is to the north, and there are doorways south and
    west. "

    /* We make the south and west properties point to the bar and
     * cloakRoom respectively. This allows normal movement from this
     * room to the other two.
     */
    south = bar
    west = cloakRoom

    /* We make the 'north' property point to a FakeConnector object,
     * which means that when the player attempts to go this way, a
     * special explanation will be printed about why the movement is
     * not permitted. For concision and convenience we write a nested,
     * anonymous definition of this FakeConnector object.
     */
    north: FakeConnector {
        "You've only just arrived, and besides, the weather outside
        seems to be getting worse. "
    }
;

/*
* Next we define an Actor, in this case the actor under player's
* control (as determined by the gameMain object, above). We'll call it
* by the fanciful name "me", since it's the object that sort of
* represents the player in the game.
*
* We use the '+' character to indicate that this object is initially
* located in the object defined immediately above. We do this instead
* of explicitly defining its 'location' property, as a shorthand
* convenience.
*
* This demonstration assumes the canonical flat PC, which the Tads-3
* library provides as the default -- so this is a very simple
* definition: we don't need to customize any properties or methods at
* all.
*
* (We could also use the Person class, which is a child of Actor, but
* this is only relevant if the object is a non-player character, of
* which in this game there are none.)
*/
+me: Actor
;

/*
* Now we define the cloak object. This object is a child of the
* Wearable class, which means that it can be worn and removed.
*
* Wearable is a child of Thing, the base class for all game objects.
* Thus it defines three strings: (1) the 'vocabWords' for this object
* define the language that the player can use when referring to this
* object; (2) the 'name' of this object, like the room name above, is
* used in messages generated by the game when referring to this object;
* (3) the "description" of the object is printed when the player
* examines the object. Here we use the Thing template for a more
* concise definition of these common properties.
*
* We use two '+' characters to indicate that it is to be initially
* located in the object defined immediately above; also, we indicate
* that it is initially being worn and is owned by the "me" object.
*
* The remainder of the definition customizes the behavior of the object
* when used in combination with the verb "drop".
*/
++cloak: Wearable 'handsome dark black velvet satin cloak' 
    'velvet cloak'
    "A handsome cloak, of velvet trimmed with satin, and slightly
    spattered with raindrops. Its blackness is so deep that it almost
    seems to suck light from the room. "

    /* The "me" object is initially wearing the cloak. */
    wornBy = me

    /* This is a simple cosmetic touch, which allows the player to
     * refer to the cloak as "my cloak" even when it is not located in
     * the player character.
     */
    owner = me

    /* dobjFor(Verb) defines this object's behavior when it is the
     * direct object of that verb in a command. The following defines
     * how this object behaves when it is the dobj of the verb "drop".
     *
     * Basically, we don't allow the cloak to be dropped outside of the
     * cloakRoom.
     */
    dobjFor(Drop)
    {
        /* There are several stages of action process, all useful in
         * different ways. Here we customize the check() phase of the
         * process.
         */
        check()
        {
            /* In keeping with good habit, we call the overridden
             * default check() routine, to allow our superclasses
             * (Wearable, Thing, etc.) a chance to disallow dropping
             * the cloak.
             *
             * inherited() simply calls this same method in our parent
             * class.
             */
            inherited();

            /* If the cloak is not in the cloakRoom, we disallow the
             * action, first printing an explanation and then exiting
             * the action process.
             */
            if (!isIn(cloakRoom))
            {
                /* A double-quoted strings is a shorthand for printing
                 * text to the screen. (This is why descriptions are
                 * double-quoted for example.)
                 */
                "This isn't the best place to leave a smart cloak lying
                around. ";
                exit;
            }
        }
    }
;

/*
* Another Room-class object, the cloakRoom.
*/
cloakRoom: Room 'Cloakroom'
    "The walls of this small room were clearly once lined with hooks,
    though now only one remains. The exit is a door to the east. "

    east = foyer
;

/*
* Next we define the hook object, upon which the cloak may be hung.
*
* The hook inherits from two classes, Surface (so things can be put on
* it) and Fixture (so that it cannot be moved around by the player).
*
* Because other objects have no need to refer to this object, this
* object doesn't need to be named. We could have written...
*
*. +hook: Fixture, Surface // etc.
*
* ...but instead we leave off the name because the object isn't going
* to need one.
*
* We could also make this object inherit from RestrictedContainer, so
* that we could disallow any object except the coat to be put on the
* hook, but because the coat is the only movable object in the game
* (other than the PC), this would be a needless complication.
*/
+Fixture, Surface
    /* This is the vocabWords property. "small" and "brass" are
     * adjectives and "hook" "peg" and "hanger" are nouns. The player
     * can refer to this object by any normal combination of these
     * words.
     */
    'small brass hook/peg/hanger'

    /* This is the name of the object, which is how the game will refer
     * to the object in automatically-generated messages.
     */
    'small brass hook'

    /* This is the description of the object; this is printed to the
     * screen when the player examines or looks at this object.
     *
     * We vary the description of the hook depending on whether the
     * cloak is hung on it. We use a couple shorthands here: the
     * material enclosed in <<>> is evaluated and the value is printed
     * within the larger string of text; the (x?y:z) structure is like
     * "if(x) y; else z;" in short form.
     */
    "It's just a small brass hook, <<cloak.location == self ? 'with a
    cloak hanging on it' : 'screwed to the wall'>>. "

    /* Because we have added special listing of the cloak in the
     * description, we want to suppress the default automatic contents
     * listing upon examine, which would be redundant. We do not,
     * however, want to suppress the normal contents listing: the cloak
     * should be shown on the hook when the player looks around the
     * room.
     */
    contentsListedInExamine = nil
    contentsListed = true

    /* Before an object (say, the cloak) is moved, the library calls a
     * few methods on the objects participating in the move.
     *
     * These methods normally don't do anything, but they are perfect
     * for triggering consequences of the move. In this case, we want
     * to increase the player's score when the cloak is moved to the
     * hook.
     *
     * The notifyInsert() method takes two arguments: (1) the object
     * being moved; and (2) the container into which the object is
     * being moved. Thus we have notifyInsert(obj, newCont)
     *
     * We could just as easily customize iobjFor(PutOn), but in
     * principle, objects can be moved by a number of actions or
     * verbs, and notifyInsert() is sure to catch all cases.
     */
    notifyInsert(obj, newCont)
    {
        /* In keeping with good habit, we inherit the normal behavior.
         */
        inherited(obj, newCont);

        /* If the object being moved is the cloak, we call upon the
         * hookScore object to award the points. If we wanted to
         * increase the score over and over again, each time the cloak
         * is hung on the hook, we would call awardPoints(), but
         * instead we just awardPointsOnce().
         */
        if (obj == cloak)
             hookScore.awardPointsOnce();
    }

    /* The hookScore property points to an anonymous object, for which
     * we give a nested definition, in the same form we use for the
     * foyer's FakeConnector, above.
     *
     * The Achievement is a simple programmatic object for registering
     * a score, in this case for hanging the cloak on the hook. It is
     * not necessary to bother with a separate Achievement object for
     * scoring, but it's a nice feature.
     *
     * Again we define the object using a template, which fills in the
     * object's "points" and "desc" properties. (The desc is used for
     * displaying a complete account of the player's score. This is
     * rather unnecessary in the case of this demonstration, but in
     * normal games this is the nicest technique.)
     */
    hookScore: Achievement { +1 "hanging the cloak on the hook" }
;

/*
* Our final room of three: the bar.
*
* This one is interesting for its handling of light, and for its
* refusal to allow the player to do anything while the room is dark.
*/
bar: Room 'Bar'
    "The bar, much rougher than you'd have guessed after the opulence
    of the foyer to the north, is completely empty. There seems to be
    some sort of message scrawled in the sawdust on the floor. "

    north = foyer

    /* All "game objects" have a property 'brightness' that indicates
     * how much light they're producing. A brightness of 3 means that
     * the object is illuminating its whole environment. A brightness
     * of 0 means that the object is producing no light whatsoever.
     *
     * By default, Room objects have a brightness of 3, which means
     * that they illuminate their area, but in this case we want the
     * room to be dark when the cloak is in it, and bright otherwise.
     *
     * Normally, brightness is a property. We make it a method instead
     * because we want to vary the brightness value depending on
     * the location of the cloak.
     */
    brightness()
    {
        /* If the cloak is in this room, the room has a brightness of
         * zero. Otherwise the room is lit as usual, with a brightness
         * of three.
         */
        if(cloak.isIn(self))
            return 0;
        return 3;
    }

    /* If the room is dark, we want to interrupt the action unless the
     * player is simply leaving the room.
     *
     * roomBeforeAction() is automatically called every time an action
     * is attempted in the room. This normally does nothing, but is
     * designed for precisely this sort of situation, where we want
     * the room to interfere with or interrupt actions.
     */
    roomBeforeAction()
    {
        /* We will not interrupt the action if the room is lit. Instead
         * we will return without further process.
         */
        if(brightness == 3)
            return;

        /* We'll allow a TravelViaAction, which is the lower-level
         * action for all travel commands, in case the player might be
         * heading north. Other directional commands will be caught
         * below, by the gAction.dirMatch.dir check.
         */
        if(gAction.ofKind(TravelViaAction))
            return;

        /* We also allow "system actions", such as SAVE or ABOUT. */
        if(gAction.ofKind(SystemAction))
            return;

        /* It might make sense to allow the player to try actions that
         * take no objects, such as 'look', but to conform with the
         * design specifications of this project we omit this
         * consideration. We could do this for example by:
         *     if(!gDobj) return;
         */

        /* Finally, we allow the move north, but disallow any other
         * action.
         */
        if(gAction.ofKind(TravelAction)) {
            if (gAction.dirMatch.dir == northDirection)
                return;

            /* If we have not already returned from this method, we are
             * interrupting the action. First, we print a scolding
             * hint, which we vary depending on what the player is
             * trying to do. Here we have a TravelAction, so we print:
             */
            "Blundering around in the dark isn't a good idea! ";

            /* Attempting travel increases the blunderCount by one
             * extra.
             */
            ++blunderCount;
       }
       else
            /* The action was not a directional command, so we print a
             * different message.
             */
            "In the dark? You could easily disturb something! ";

        /* Then we increase our blunder counter by one. */
        ++blunderCount;

        /* And finally we exit, effectively interrupting the action. */
        exit;
    }

    /* We introduce a new property to keep track of how many times the
     * player has blundered around in the dark. This will determine the
     * outcome of the game. (See the "message" object, below.)
     *
     * This is initially set to zero: at the beginning of the game, the
     * player has not blundered around at all.
     */
    blunderCount = 0
;

/*
* Finally, there's a message on the floor of the bar.
*
* The description varies depending on how much the player blundered
* around while the bar was dark. The game ends upon printing this
* description.
*
* We make this object a Fixture, so that it cannot be moved around, and
* we make it Readable, so it can be "read" as well as examined.
*/
+Fixture, Readable

    /* We complicate the vocabWords of this object a bit, to allow for
     * such phrasings as "read the message scrawled in sawdust".
     */
    'message scrawled in sawdust'

    /* The name is normal. */
    'scrawled message'

    /* We make a method of the desc, which is normally a property, so
     * that we can vary the description based on how much blundering
     * the player did.
     */
    desc()
    {
        /* If the player blundered around too much, the message says
         * that the player lost the game.
         */
        if (bar.blunderCount > 2)
        {
            "The message has been carelessly trampled, making it
            difficult to read. You can just distinguish the words...";

            /* We call finishGameMsg(), which finishes the game by
             * printing a message and providing some options for the
             * player. The first argument is the parting message, and
             * the second argument is a list of any additional options
             * we want to provide the player. We want to allow players
             * to check their "full score", so we include this option
             * in the list.
             */
            finishGameMsg('You have lost', [finishOptionFullScore]);
        }

        /* If the player didn't blunder around in the bar too much,
         * the message reads differently.
         */
        else {
            /* The message is undisturbed, so we award a point for
             * winning the game, print a message and end the game.
             */
            messageScore.awardPoints();
            "The message, neatly marked in the sawdust, reads...";
            finishGameMsg('You have won', [finishOptionFullScore]);
        }
    }
    messageScore: Achievement { +1 "winning the game" }
;

/*
* And last, we define a new verb to handle the command "hang x on y".
*
* We make it a TIAction, which means it takes two objects (x and y),
* and we define its grammar rule, action, and verbPhrase, which is
* used in automatically generated messages (disambiguation questions
* and implicit action messages).
*/
DefineTIAction(HangOn);
VerbRule(HangOn)
    'hang' singleDobj ('on' | 'upon') singleIobj
    : HangOnAction
    verbPhrase = 'hang/hanging (what) (on what)'
;

/*
* We modify Thing so that HangOn works the same way as PutOn, whether
* the object is being used as the direct object or the indirect object.
*
* We could instead have made the HangOn VerbRule point to the
* PutOnAction rather than the HangOnAction, but this is perhaps a bit
* clearer, and allows a minor demonstration of action remapping.
*/
modify Thing
    dobjFor(HangOn) asDobjFor(PutOn)
    iobjFor(HangOn) asIobjFor(PutOn)
;

/*
* Thanks for your interest. Feel free to contact the author with any
* questions or suggestions. (The email address is near the top of this
* file.)
*
* Though we've erred on the side of elaboration in the comments, we
* hope you've found that the code itself is fairly compact. With the
* comments removed, it is, for comparison, about the length of the
* corresponding Inform version of this demonstration -- a little over
* 100 lines.
*/


-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: jobdata
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `applications`
--

LOCK
TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications`
VALUES (1, 2, '2022-12-27 12:02:05', '0', 'Guten Tag, das ist eine Bewerbung.', '<link>', NULL),
       (4, 1, '2022-12-27 00:40:08', '0', 'Ich will in die Gruppe!', '<link>', NULL);
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK
TABLES;


--
-- Dumping data for table `currents`
--

LOCK
TABLES `currents` WRITE;
/*!40000 ALTER TABLE `currents` DISABLE KEYS */;
/*!40000 ALTER TABLE `currents` ENABLE KEYS */;
UNLOCK
TABLES;

--
-- Dumping data for table `jobs`
--

LOCK
TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs`
VALUES (1, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL, 'Ferienjob',
        'Das ist ein Ferienjob', NULL, NULL, NULL, '2022-12-24 10:00:00', NULL, 0, 0, 0),
       (2, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:36:26', 1, 0, 0, 0, NULL,
        'Lehrkraft (m/w/d) an einer Regionalen Schule in Schwerin ',
        'Dies ist eine Stelle, die automatisch vom Karriereportal www.Lehrer-in-MV.de an die Arbeitsargentur übermittelt wurde.\r\n\r\nDie Website www.Lehrer-in-MV.de ist das Karriereportal für den Schuldienst in Mecklenburg-Vorpommern und wird durch das Ministerium für Bildung und Kindertagesstätten betrieben, um pädagogisches Personal für die rund 500 öffentlichen allgemein bildenden und beruflichen Schulen des Landes Mecklenburg-Vorpommern zu interessieren und einzustellen.\r\n\r\nDie Einstellung ist auch zu einem früheren Zeitpunkt möglich, sofern die haushaltsrechtliche Möglichkeit besteht und dies seitens der Bewerberin bzw. des Bewerbers gewünscht ist.\r\nGesuchte Fächer:\r\n1. Mathematik\r\n2. Physik\r\n3. Arbeit/Wirtschaft/Technik\r\n\r\nVerbeamtung:\r\nDie unbefristeten Einstellungen von Lehrkräften erfolgen bei Vorliegen der laufbahnrechtlichen und sonstigen Einstellungsvoraussetzungen grundsätzlich im Beamtenverhältnis. Liegen die Voraussetzungen für eine Verbeamtung nicht vor bzw. wird eine Verbeamtung durch die Bewerberin oder den Bewerber nicht gewünscht, erfolgt die Beschäftigung im Tarifbeschäftigtenverhältnis.',
        NULL, NULL, NULL, '2022-12-24 10:00:00', NULL, 0, 0, 0),
       (3, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Psychologin / Psychologe bzw. Psychologischer Psychotherapeut (w/m/d)',
        'Behandlungszentrum Kempfenhausen | Kempfenhausen am Starnberger See\r\nIhr Profil: Approbation als Psychologischer Psychotherapeut/-in (m/w/d) vorhanden oder angestrebt; Verhaltenstherapeutische Ausbildung vorhanden oder weit fortgeschritten (75%); Zusatzausbildung in spezieller Schmerztherapie vorhanden oder angestrebt; Erfahrung in der Leitung von Gruppen; Empathie und Sozialkompetenz; Teamfähigkeit',
        NULL, NULL, NULL, '2022-12-24 10:10:00', NULL, 0, 0, 0),
       (4, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Dozent Sozialgeschichte, Philosophie, Ethik (m/w/d)',
        'U Internationale Hochschule GmbH | Freiburg\r\nStart: Ab; Campus: Freiburg; Studiengang: Soziale Arbeit; Modul: Sozialgeschichte, Philosophie, Umfang: 36 Unterrichtseinheiten (45 Minuten pro Unterrichtseinheit); Beschäftigungsart: Freiberufliche:r Honorarbeauftrage:r. Eine konkrete Modulbeschreibung zu unserem Kurs findest Du unter folgendem Link: Soziale Arbeit Dein Profil: Abgeschlossenes Hochschulstudium oder gleichwertiger Bildungsabschluss; Praktische Berufserfahrung in dem zu unterrichtenden Fachgebiet; Fließende Deutschkenntnisse (mind. C1) in Wort und Schrift; Lehrerfahrung ist ein Pluspunkt aber kein Muss. ',
        NULL, NULL, NULL, '2022-12-24 10:10:00', NULL, 0, 0, 0),
       (5, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL, ' Zolldeklarant (m/w/d)',
        'altona Diagnostics GmbH | Hamburg\r\nKommen Sie zu uns, wenn Sie dieselbe Philosophie teilen! Zur Verstärkung unseres Logistics-Teams in Hamburg suchen wir zum nächstmöglichen Zeitpunkt einen hoch motivierten und engagierten. Zolldeklarant (m/w/d): Laufende Überprüfung der Zolltarife; Pflege und Kontrolle der zollbezogenen Materialdaten in unserem ERP-System; Tarifierung neuer Produkte; Überprüfung der Export Codes, ggf. in Abstimmung mit der Exportkontrolle; Erstellung und Überwachung von Carnets, inkl. Betreuung vorübergehender Ausfuhren; Unterstützung bei den täglichen Zollanmeldungen; Aktives Auftragsmonitoring und Ableitung von Maßnahmen bei Abweichungen, z.B. bei der Rückweisung durch die Zollbehörden; Komptenter Ansprechpartner für die Zollbehörde und die Außenwirtschaftsprüfer.',
        NULL, NULL, NULL, '2022-12-24 10:10:00', NULL, 0, 0, 0),
       (6, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Lehrbeauftragter Sozialgeschichte, Philosophie, Ethik (m/w/d)',
        'IU Internationale Hochschule GmbH | bundesweit\r\nUnterstützen Sie uns im Kombistudium ab Januar am Virtuellen Campusals Lehrbeauftragter auf Honorarbasis (m/w/d) in dem Studiengang Soziale Arbeit, Modul: Sozialgeschichte, Philosophie, Ethik Eine Modulbeschreibung finden Sie hier: (ff.) Die Lehrveranstaltungen im Kombistudium umfassen je Modul 18 Unterrichtseinheiten à 45 Minuten. ',
        NULL, NULL, NULL, '2022-12-24 10:08:00', NULL, 0, 0, 0),
       (7, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Praktikum im Bereich Global Travel Management ab Februar 2023',
        'Mercedes-Benz Group AG | Stuttgart\r\nDu bist immatrikulierte*r Student*in reisebegeistert und studierst Tourismusmanagement, Wirtschaftswissenschaften oder Vergleichbares. Was solltest du außerdem im Reisegepäck haben? Einen sicheren Umgang mit MS Office – insbesondere Excel und Power Point; Gute schriftliche und mündliche Kenntnisse in Deutsch und Englisch; Analytische Denkweise, schnelle Auffassungsgabe und strategische Arbeitsweise; Vollzeitverfügbarkeit von mindestens 5 Monate; Dynamik, Leidenschaft und Teamfähigkeit. ',
        NULL, NULL, NULL, '2022-12-24 10:08:00', NULL, 0, 0, 0),
       (8, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Duales Studium Tourismusmanagement ab August 2023',
        'A-ROSA Travemünde | Travemünde\r\nDann bewirb Dich jetzt und starte Dein Duales Studium Tourismusmanagement bei uns! Deine Aufgaben; Das Duale Studium Tourismusmanagement ist die perfekte Mischung aus Theorie und Praxis. In unserem Resort wirst Du im Praxisteil folgende Abteilungen kennenlernen: Empfang; Gästeservice; und viele mehr. ',
        NULL, NULL, NULL, '2022-12-24 05:03:00', NULL, 0, 0, 0),
       (9, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Pflichtpraktikum mit Schwerpunkt Kunden- und Berechtigungsmanagement',
        'Fraport AG | Frankfurt am Main\r\nStudium der Wirtschaftswissenschaften, Sicherheits- bzw. Tourismusmanagement oder Verkehrswesen; Sehr gutes Kommunikationsvermögen sowie gute Allgemeinbildung; Gutes Ausdrucksvermögen in Wort und Schrift sowie gute Englischkenntnisse in Wort und Schrift; Hohes Maß an Belastbarkeit, Serviceorientierung und Einsatzbereitschaft; Selbstständige, eigenverantwortliche und strukturierte Arbeitsweise; Sehr gute MS-Office Kenntnisse (insb. Excel und Power Point); Gepflegtes äußeres Erscheinungsbild; Schnelle Auffassungsgabe und gute analytische Fähigkeiten. ',
        NULL, NULL, NULL, '2022-12-24 07:03:00', NULL, 0, 0, 0),
       (10, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Praktikant im Sponsoring mit Schwerpunkt für Sport, Kunst und Kultur (m/w/d)',
        'Allianz Kunde und Markt GmbH | Unterföhring (bei München)\r\nDas erwartet dich: Du bringst neue Ideen bei der Konzeption und Entwicklung von Sponsoring-Maßnahmen in den Bereichen Sport, Kunst und Kultur ein; Du übernimmst organisatorische Aufgaben und Teilprojekte; Du hilfst mit bei der Vorbereitung und Durchführung von Events, Workshops, etc. Du unterstützt das Referat bei weiteren anfallenden Arbeiten (z. B. Agenturkorrespondenz, Ticketing etc.); Das bringst du mit: Du befindest im Bachelor- oder Masterstudium vorzugsweise eines wirtschafts-, sport- oder kommunikationswissenschaftlichen Studiengangs, gerne mit Schwerpunkt Sportmedien und -kommunikation, Sportökonomie, Marketing oder Eventmanagement; Du bist zuverlässig, engagiert und weißt mit vertraulichen Informationen diskret umzugehen; Du zeichnest dich durch deine Teamfähigkeit aus und zeigst dich kontaktfreudig und kreativ; Du bringst Interesse für den Bereich Sportmarketing / Sportsponsoring mit; Der sichere Umgang mit MS Office, (Power Point und Excel) ist für dich selbstverständlich; Du verfügst über sehr gute Deutsch- & Englischkenntnisse. ',
        NULL, NULL, NULL, '2022-12-24 07:45:00', NULL, 0, 0, 0),
       (11, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Praktikant (m/w/d) Redaktion & Produktion für unser Politikformat ATLAS',
        'LEONINE Holding GmbH | Berlin\r\nFür unsere erfolgreichen Formate DISSLIKE und FRAG EIN KLISCHEE haben wir den Grimme Online Award 2015 in der Rubrik Kunst und Unterhaltung“ erhalten. 2018 kam der Grimme-Preis in der Kategorie Kinder und Jugend” für das Format GERMANIA sowie die Goldene Kamera im Bereich Special Award You Tube hinzu. ',
        NULL, NULL, NULL, '2022-12-24 06:45:00', NULL, 0, 0, 0),
       (12, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Praktikum bei der Munich Re Art Collection (m/w/d)*',
        'Münchener Rückversicherungs-Gesellschaft AG | München\r\nDie Munich Re Art Collection umfasst über 3000 Kunstwerke – von Malerei, Fotografie, Skulptur bis hin zu architekturbezogenen Installationen. Im Fokus der Sammlung steht das Engagement für internationale und junge zeitgenössische Kunst. Aufgrund der mehr als 140-jährigen Sammlungstätigkeit gibt es eine Vielzahl an Kunstwerken aus den unterschiedlichen Dekaden. ',
        NULL, NULL, NULL, '2022-12-24 09:45:00', NULL, 0, 0, 0),
       (13, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Praktikant im Bereich Kunstversicherung / vermögende Privatkunden (m/w/d)',
        'AXA XL, a division of AXA | München, Köln, Hamburg\r\nDiese wesentlichen Aufgaben erwarten Sie bei uns: Mitarbeit in unseren zentralen oder dezentralen Underwriting Teams, die größtenteils aus Kunsthistorikern/Innen bestehen; Selbstständige Recherche und Ermittlung des aktuellen Versicherungswertes für Kunstobjekte; Erstellung und Pflege von Kunstlisten; Einarbeitung in verschiedene Datenbanken u.a. artnet; Mitwirkung bei der Vor- und Nachbereitung von Kunden- und Geschäftspartnerterminen; Mitwirkung bei der Angebotserstellung im Bereich Kunst/vermögende Privatkunden; Unterstützung und Mitwirkung in Projekten (Vertrieb, Prozesse, etc.) nach Absprache möglich. ',
        NULL, NULL, NULL, '2022-12-24 09:45:00', NULL, 0, 0, 0),
       (14, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Praktikant / Werkstudent (m/w/d) Brand Marketing & Communication – ab Februar/März 2023',
        'Stryker | Kiel\r\nDas zeichnet Dich aus: Du studierst Betriebswirtschaftslehre mit der Fachrichtung Medien, Marketing oder Kommunikation, Kommunikationswissenschaften, Kunst oder Psychologie. Mit Deiner starken Begeisterungsfähigkeit und positiven Persönlichkeit verstehst Du es, andere Leute mitzureißen und zu motivieren. ',
        NULL, NULL, NULL, '2022-12-24 09:45:00', NULL, 0, 0, 0),
       (15, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Kulturelle Mitarbeit/Kunst Kultur Natur',
        'Gutshaus Woserin - Kunst am See | Borkow\r\nInmitten von Mecklenburg, direkt an einem See habe ich eine kleine feine Kunstakademie gegründet. Eine / einen Praktikantin oder Praktikanten. Schau dich auf der Webseite um, ich freue mich über mails! Gutshaus Woserin; Kunst am See] (https://www.gutshausamsee.de) Wenn du Lust an der Entwicklung von Projekten hast, gern auch handwerklich arbeitest und momentan nicht ins Ausland reisen kannst, doch am schönsten Ende der Welt ein Praktikum machen möchtest, dann melde dich! ',
        NULL, NULL, NULL, '2022-12-24 12:45:00', NULL, 0, 0, 0),
       (16, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        'Definitiv kein ponzi  scheme', 'KOMM IN DIE GRUPPE!', NULL, NULL, NULL, '2022-12-25 01:01:00', NULL, 0, 0, 0),
       (17, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Volontär*in (m/w/d) Gesellschaftswissenschaften',
        'Cornelsen Verlag GmbH | Berlin\r\nAls Teil eines unserer Redaktionsteams unterstützt du unsere erfahrenen Autor*innen und Redakteur*innen bei der Erarbeitung von Unterrichtsmaterialien (print und digital) im Bereich Gesellschaftswissenschaften (Geschichte, Erdkunde, Politik/Wirtschaft); Wir bilden dich in allen für die Redaktionsarbeit relevanten Tätigkeiten aus, sodass du schrittweise eigenverantwortlich kleinere Projekte betreuen kannst; Innerhalb deines Volontariats lernst du unser digitales Portfolio kennen und hilfst aktiv dabei mit, dieses zu pflegen und auszubauen; Die Text- und Bildrecherche in Datenbanken sowie die Arbeit mit internen und externen Dienstleister*innen ist ebenfalls Teil deines Aufgabengebietes; Ziel des Volontariats ist es, unseren redaktionellen Bereich in seiner Gänze kennenzulernen. ',
        NULL, NULL, NULL, '2022-12-24 02:01:00', NULL, 0, 0, 0),
       (18, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        ' Volontär*in (m/w/d) Gesellschaftswissenschaften',
        'Cornelsen Verlag GmbH | Berlin\r\nAls Teil eines unserer Redaktionsteams unterstützt du unsere erfahrenen Autor*innen und Redakteur*innen bei der Erarbeitung von Unterrichtsmaterialien (print und digital) im Bereich Gesellschaftswissenschaften (Geschichte, Erdkunde, Politik/Wirtschaft); Wir bilden dich in allen für die Redaktionsarbeit relevanten Tätigkeiten aus, sodass du schrittweise eigenverantwortlich kleinere Projekte betreuen kannst; Innerhalb deines Volontariats lernst du unser digitales Portfolio kennen und hilfst aktiv dabei mit, dieses zu pflegen und auszubauen; Die Text- und Bildrecherche in Datenbanken sowie die Arbeit mit internen und externen Dienstleister*innen ist ebenfalls Teil deines Aufgabengebietes; Ziel des Volontariats ist es, unseren redaktionellen Bereich in seiner Gänze kennenzulernen. ',
        NULL, NULL, NULL, '2022-12-24 03:01:00', NULL, 0, 0, 0),
       (19, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 1, 0, 0, 0, NULL,
        'Volontär / Praktikant (d/m/w) im Bereich strategische Regionalentwicklung',
        'Prognos AG – Wir geben Orientierung. | Düsseldorf\r\nWenn Sie auf der Suche nach einer sinnstiftenden Tätigkeit in einem renommierten und zugleich innovativen Institut sind, das auch als Arbeitgeber beeindruckt, freuen wir uns auf Sie. Arbeiten bei Prognos: Was Sie als Top-Talent erwartet. Wir bei Prognos richten unseren Blick auf die Zukunft.',
        NULL, NULL, NULL, '2022-12-24 08:01:00', NULL, 0, 0, 0),
       (20, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 2, 0, 0, 0, NULL,
        'Public relations specialist',
        'Primary duties: Public relations specialists are tasked with creating and maintaining a positive public image, either for the company that they work with or for an outside client who hires their services. They do that by creating material for various media platforms, managing public relations programs and other similar activities. As a gender studies major, your acquired skills can help you train employers, clients and the general public on various societal and cultural norms that need to be respected in today\'s society.',NULL,NULL,NULL,'2022-12-24 16:55:00',NULL,0,0,0),(21,NULL,0,'public','2022-12-23 22:14:42','2022-12-23 22:14:42',2,0,0,0,NULL,'Political campaign manager','Primary duties: A campaign manager is tasked with coordinating various aspects of a political campaign\'s operations, like fundraising, spreading various political messages across, convincing the public to vote, advertising, communicating with the media and other similar duties. A gender studies graduate can be an asset to a political campaign, as they can educate politicians regarding the current trends regarding gender relations.',
        NULL, NULL, NULL, '2022-12-24 03:23:00', NULL, 0, 0, 0),
       (22, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 2, 0, 0, 0, NULL, 'Communications manager',
        'Primary duties: A communications manager typically leads a team of communication professionals that represent a company or institution to the public and its stakeholders. They handle all internal and external communication and have the overall goal of making sure the company or institution\'s message and vision are properly communicated. Although the role also requires experience in a communications-based role,
        a gender studies degree can help you handle internal and external communications on delicate issues regarding gender.',NULL,NULL,NULL,'2022-12-24 05:23:00',NULL,0,0,0),(23,NULL,0,'public','2022-12-23 22:14:42','2022-12-23 22:14:42',2,0,0,0,NULL,'Teacher','Primary duties: Teachers help their students learn and develop valuable skills to be used in their careers and everyday lives. Teachers assist their students in growing their hard skills,
        such as mathematical abilities, as well as their soft skills,
        such as communication. A teacher\'s daily responsibilities vary depending on the age level they teach and if they specialize in a certain subject. WGSS graduates can often communicate complex social concepts in a way that students understand and help teach them to be open-minded. Related careers include being a professor',
        NULL, NULL, NULL, '2022-12-24 15:23:00', NULL, 0, 0, 0),
       (24, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 2, 0, 0, 0, NULL, 'Librarian',
        'Primary duties: Librarians organize, manage and help people find information at public libraries, research organizations, schools and government agencies. Responsibilities often include sorting through digital or physical archives, helping people with personal or professional research, leading literacy classes or advocacy programs, cataloging materials and maintaining databases. A WGSS graduate might seek this role to exercise their critical thinking skills, help others develop literacy skills or organize information processes.',
        NULL, NULL, NULL, '2022-12-24 18:23:00', NULL, 0, 0, 0),
       (25, NULL, 0, 'public', '2022-12-23 22:14:42', '2022-12-23 22:14:42', 2, 0, 0, 0, NULL, 'Town manager',
        'Primary duties: People with WGSS backgrounds are good candidates for the role of town manager, also called city manager, who acts as the chief executive of a town\'s government. They know about many social issues that affect city management such as pay equity and access issues to community resources. Town managers oversee all government staff employed by their city. They also budget for,
        manage and regulate city services such as public schools, city streets, public transportation and sanitation
        systems.',NULL,NULL,NULL,' 2022 - 12 - 24 06 : 23 : 00 ',NULL,0,0,0),(26,NULL,0,' public ',' 2022 - 12 - 23 22 :
        14 : 42 ',' 2022 - 12 - 23 22 : 14 : 42 ',2,0,0,0,NULL,' Diversity and inclusion manager ',' Primary duties :
        Diversity and inclusion managers design, implement and manage programs related to diversity and inclusion,
        including diverse hiring outreach and practices, in the workplace.They also design workplace policies and events
        to promote inclusion,
        appreciate various cultures and offer accessibility practices or tools. WGSS graduates are good candidates for this profession since they understand how various social and cultural influences can shape human interactions.',NULL,NULL,NULL,'2022-12-24 07:02:00',NULL,0,0,0),(27,NULL,0,'private','2022-12-26 23:24:48','2022-12-27 11:13:15',2,0,0,0,NULL,'Genderstudies Nachhilfe','Nachhilfe gesucht.',NULL,NULL,NULL,'2022-12-25 12:12:00',NULL,0,0,0);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (0,1,'0'),(0,3,'1'),(0,4,'1'),(0,5,'1'),(0,6,'1'),(0,7,'1'),(0,8,'1'),(0,9,'1'),(0,10,'1'),(0,11,'1'),(0,12,'1'),(0,13,'1'),(0,14,'1'),(0,15,'1'),(0,16,'0'),(0,17,'0'),(0,18,'0'),(0,19,'0'),(0,20,'0'),(0,21,'0'),(0,22,'0'),(0,23,'0'),(0,24,'0'),(0,25,'0'),(0,26,'0'),(1,2,'0'),(2,27,'0');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'carlobortolan@gmail.com','$2a$12$WRYOVw.vTyzS6kIGdb9TZe4QQKIcNjUc52FdPHlP3nqRXF4uY7aBm','2001-01-01 00:00:00.000000','2022-12-27 12:46:27.491433',0,NULL,'Carlo','Bortolan'),(2,'carlo.bortolan@tum.de','$2a$12$t902vmxqLvniAOSrOz6c3.XEh.jJEEukFKqRJo2qNBeABA46T//eu','2022-12-27 10:14:53.202587','2022-12-27 12:43:13.068606',0,NULL,'Carlo','Bortolan');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-27 13:48:15

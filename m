Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFAC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 00:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40A25402E1;
	Tue,  1 Apr 2025 02:47:02 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id 73E1E40B9B
 for <dev@dpdk.org>; Tue,  1 Apr 2025 02:47:00 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-226185948ffso96949235ad.0
 for <dev@dpdk.org>; Mon, 31 Mar 2025 17:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743468419; x=1744073219; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n6AmvpH8StRCewosxl5Jo4G4Y7tS1Zdfn+VxtRj++Og=;
 b=XBoAkXJEGYD/po6nhaoPeVFbO4fqx3DVZ9T3MAa6yk+aQ4ZIA5GPPzcIBMkubdvsO+
 nXSIKfKuAe3y9HGKh6FHw9WW63kEKtlLI4HGV006c0iLnF8+U85V9muyOepstE+AX3ki
 /2os66yTzX7RQNERYhnFlAHeLuXPOC8ptQvs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743468419; x=1744073219;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n6AmvpH8StRCewosxl5Jo4G4Y7tS1Zdfn+VxtRj++Og=;
 b=PjCA5cV/lRocUywCv8G+G1iexXW7PpXY1FUZbLf7QjuHoLTquwUOuRnabQoWzXmV8x
 GW/1PzRGKa8kH0n7/Hk8e3rnqPuRQOVACGq5V71GInabcMX9z+8riouh5xVq8hOqHnsZ
 Q3muIXOvSw58bf+xKvvRIXW0BTUdHZMqf1jeMdmriOXLMSFTiuDepuHvANJ4SipA4xMA
 D9hbndZ+8l9wBqtavD+MihvnC3U9lVS86HOa6/vqj8lduoD0nAjV4VW6YXiflS8cHWWM
 3CGBa1AJ7Sqj/DocJ4f0XVVOnPBqB4iWIP2XBcDTsTHh1KVm0Xmru7qt+FCRkwT4RRXt
 nZ/g==
X-Gm-Message-State: AOJu0YzF5oHwoiOSS6HzavYpRGuhA+kSKKNVsgGBjcFXEg0MD6Cj+rgh
 vWuIHYGHKt69iXrgc5pweKJPoQES239OW+9I9X9+hv2hbyu/YJ2Uwid8WYBm8Aa/QcMUvVvKQcj
 bG5NuYr2hrZWsQZ4CpgJyY7+31r5DRdJ1ZUAgLr3qoYutlHj880KisQ==
X-Gm-Gg: ASbGnctnnEqkH/55e4hZ5eqqHmAlNWEKvARVnsSBfzklIgBGzR4y769YqOLEhk62ytb
 aTLqCZGtyYauWKkQlTRUKWmvoFz9NvxeAsv5mDn6jbBsASzPN8HtS507TavFjY3gvvcTJW+2Whc
 b8nUAQzFq8GuZBPlB9MdK+cs7EtzsNpnIvaGa96ezqbA==
X-Google-Smtp-Source: AGHT+IHAU4wV37Tbn7aUFwx9lFyxK1KPjzA8h4ErfqIGVcH9lCj4PEhmjGAiEcqbnp2GbJSxMr7zwWWE/+GqISPrm5U=
X-Received: by 2002:a17:902:ce89:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-2292f944d1bmr183223465ad.5.1743468417462; Mon, 31 Mar 2025
 17:46:57 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 31 Mar 2025 20:42:58 -0400
X-Gm-Features: AQ5f1Jr3CyxqFTCMdsZA-fDbRe04Cn8wiKdV3YmrsJehB7sfpIXxD1dk3W5kDew
Message-ID: <CAJvnSUCXK4A_SLqoQvhRJo95EcbYt2MfZ4zOHF3xLjO0F+miBg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - March 27, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b354ec0631acdf3f"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000b354ec0631acdf3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
March 27, 2025
Attendees
* Patrick Robb
* Luca Vizzarro

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* DPDK 25.03 has been released
* We are aggregating the patches/tickets for the 25.07 DTS roadmap. Initial
proposals are:
   * 1. TG abstraction rework (to facilitate performance TGs), testsuite
API additions for perf workloads, and TREX class implementation
      * Luca raised that it may be best to leave the perf TGs as child
classes of the current tg abstract class and simply not implement the
capturing methods
      * Luca also raises that his asyncsniffer patchseries adds some new
methods of collecting packets, such as collecting until a stop condition is
met (like seeing packet X). This may split out packet send and packet
capture from send_packet_and_capture(), making them independent.
   * 2. Write testsuite perf_single_core_fwd
   * 3. Write testsuite rte_flow
   * 4. Port VF support
   * 5. Docs improvements for new users
      * Luca has indicated that Thomas Wilks will contribute to this
   * 6. Smoke test tweaks to ensure they are not a setup burden
   * 7. Rework packet send and receive functions in the Testsuite API
towards supporting IP networking in an L3 environment
   * 8. DPDK Testsuite API: This will provide a stable API which will not
be broken going forward (except at agreed upon intervals)
   * 9. RSS Support Testsuites
      * Work for this is basically done - reviews needed though:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34713
   * 10. Non-Development roadmap goals include: Filming a video series
explaining DTS usage, scheduling syncs with testers/developers from DPDK
member companies to introduce them to DTS.
   * 11. Update TestResult module in order to give a more human readable
summary of the testsuites
   * 12. Improved interactive shell data collection and logging.
      * Add a file which exclusively logs the shell interactions
   * 13. Add dedicated file manager to handle passing files and artifacts
between the test engine and nodes in a path agnostic manner
      * This will be a component of the new DPDK DTS API
   * 14. Flexible port binding
      * Give the opportunity to test suites to use all or part of the
supplied port topology with the kernel drivers (instead of DPDK). Could be
achieved with a decorator
      * This will require the Topology class to be aware of what=E2=80=99s =
truly
available for DPDK and provide only the right ports for it
   * Move these over to:
https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWt=
xnko/edit?tab=3Dt.0
* This is a friendly reminder that when you start working on a testsuite,
you should make sure there is a ticket documenting that on DPDK/DTS bugzill=
a
* Smoke tests do not run from next-dts currently, due to a patch from the
per-test-suites-configuration patch from the end of 25.03.
   * Patrick will submit a fix
   * Also, it is worth discussing the usefulness of the smoke tests
generally:
      * Some tests are confirming simple setup correctness and help
validate DTS has been configured right, while others are testing DPDK more
broadly (like the dpdk-test runs) and may pose a burden to developers
         * One option is to keep the smoke tests as they are but default
them to off instead of on

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* Per testsuite configuration:
   * merged
* VF port support:
   * In progress
* TREX perf TG support:
   * RFC should be submitted this week or next
Bugzilla discussions
* Thomas M cleaned up the Bugzilla board some
* Patrick cleaned up some other tickets - worth taking 1 more look at it
will Paul at a future meeting.
* No other Bugzilla discussion

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next meeting is April 10, 2025

--000000000000b354ec0631acdf3f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>March 27, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Vizz=
arro<br><br>###############################################################=
######<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>General Discussion<br>* DPDK 25.03 has been released<br>* We a=
re aggregating the patches/tickets for the 25.07 DTS roadmap. Initial propo=
sals are:<br>=C2=A0 =C2=A0* 1. TG abstraction rework (to facilitate perform=
ance TGs), testsuite API additions for perf workloads, and TREX class imple=
mentation<br>=C2=A0 =C2=A0 =C2=A0 * Luca raised that it may be best to leav=
e the perf TGs as child classes of the current tg abstract class and simply=
 not implement the capturing methods<br>=C2=A0 =C2=A0 =C2=A0 * Luca also ra=
ises that his asyncsniffer patchseries adds some new methods of collecting =
packets, such as collecting until a stop condition is met (like seeing pack=
et X). This may split out packet send and packet capture from send_packet_a=
nd_capture(), making them independent.<br>=C2=A0 =C2=A0* 2. Write testsuite=
 perf_single_core_fwd<br>=C2=A0 =C2=A0* 3. Write testsuite rte_flow<br>=C2=
=A0 =C2=A0* 4. Port VF support<br>=C2=A0 =C2=A0* 5. Docs improvements for n=
ew users<br>=C2=A0 =C2=A0 =C2=A0 * Luca has indicated that Thomas Wilks wil=
l contribute to this<br>=C2=A0 =C2=A0* 6. Smoke test tweaks to ensure they =
are not a setup burden<br>=C2=A0 =C2=A0* 7. Rework packet send and receive =
functions in the Testsuite API towards supporting IP networking in an L3 en=
vironment<br>=C2=A0 =C2=A0* 8. DPDK Testsuite API: This will provide a stab=
le API which will not be broken going forward (except at agreed upon interv=
als)<br>=C2=A0 =C2=A0* 9. RSS Support Testsuites<br>=C2=A0 =C2=A0 =C2=A0 * =
Work for this is basically done - reviews needed though: <a href=3D"https:/=
/patchwork.dpdk.org/project/dpdk/list/?series=3D34713">https://patchwork.dp=
dk.org/project/dpdk/list/?series=3D34713</a><br>=C2=A0 =C2=A0* 10. Non-Deve=
lopment roadmap goals include: Filming a video series explaining DTS usage,=
 scheduling syncs with testers/developers from DPDK member companies to int=
roduce them to DTS.<br>=C2=A0 =C2=A0* 11. Update TestResult module in order=
 to give a more human readable summary of the testsuites<br>=C2=A0 =C2=A0* =
12. Improved interactive shell data collection and logging.<br>=C2=A0 =C2=
=A0 =C2=A0 * Add a file which exclusively logs the shell interactions<br>=
=C2=A0 =C2=A0* 13. Add dedicated file manager to handle passing files and a=
rtifacts between the test engine and nodes in a path agnostic manner<br>=C2=
=A0 =C2=A0 =C2=A0 * This will be a component of the new DPDK DTS API<br>=C2=
=A0 =C2=A0* 14. Flexible port binding<br>=C2=A0 =C2=A0 =C2=A0 * Give the op=
portunity to test suites to use all or part of the supplied port topology w=
ith the kernel drivers (instead of DPDK). Could be achieved with a decorato=
r<br>=C2=A0 =C2=A0 =C2=A0 * This will require the Topology class to be awar=
e of what=E2=80=99s truly available for DPDK and provide only the right por=
ts for it<br>=C2=A0 =C2=A0* Move these over to: <a href=3D"https://docs.goo=
gle.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mCeDBWtxnko/edit?tab=3D=
t.0">https://docs.google.com/document/d/1doTZOOpkv4D5P2w6K7fEJpa_CjzrlMl3mC=
eDBWtxnko/edit?tab=3Dt.0</a><br>* This is a friendly reminder that when you=
 start working on a testsuite, you should make sure there is a ticket docum=
enting that on DPDK/DTS bugzilla<br>* Smoke tests do not run from next-dts =
currently, due to a patch from the per-test-suites-configuration patch from=
 the end of 25.03.<br>=C2=A0 =C2=A0* Patrick will submit a fix<br>=C2=A0 =
=C2=A0* Also, it is worth discussing the usefulness of the smoke tests gene=
rally:<br>=C2=A0 =C2=A0 =C2=A0 * Some tests are confirming simple setup cor=
rectness and help validate DTS has been configured right, while others are =
testing DPDK more broadly (like the dpdk-test runs) and may pose a burden t=
o developers<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* One option is to keep t=
he smoke tests as they are but default them to off instead of on<br><br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions=
<br>* Per testsuite configuration:<br>=C2=A0 =C2=A0* merged<br>* VF port su=
pport:<br>=C2=A0 =C2=A0* In progress<br>* TREX perf TG support:<br>=C2=A0 =
=C2=A0* RFC should be submitted this week or next<br>Bugzilla discussions<b=
r>* Thomas M cleaned up the Bugzilla board some<br>* Patrick cleaned up som=
e other tickets - worth taking 1 more look at it will Paul at a future meet=
ing.<br>* No other Bugzilla discussion<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next meeting is A=
pril 10, 2025<br><br><br></div>

--000000000000b354ec0631acdf3f--

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B54EFCE53
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 23:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 304324067C;
	Thu,  5 Mar 2026 00:31:28 +0100 (CET)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id CA59F4029D
 for <dev@dpdk.org>; Thu,  5 Mar 2026 00:31:26 +0100 (CET)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1273349c56bso9146167c88.0
 for <dev@dpdk.org>; Wed, 04 Mar 2026 15:31:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772667086; cv=none;
 d=google.com; s=arc-20240605;
 b=dW2oFgEdfO4nBFga1rcsdPZXrprQQmGjmoUhcZCBIAQMBZB1ws8oTpwXK7IXM0Z/aU
 dYMf7pO0S9aCFspVuPYZWkyWP4g8NZWVup9jC8Kjr5g08rt+Gza1NBJRSAxgDE7f5Naz
 shWTBynPr15tWsWDR6rkk3ogMBnJpiszN29oMM42bg6UpiMlbyg/h8nIw/oVAQxiyuq0
 Efhrb8GIotoxOJ7woxQDWXX+sqs+Ku/4jnN4o2uhg8KyDXJSCPTgHrddyIkUBDGLI7lc
 OGUuKKA6id5YzLswkimEmuq8+yTXOoVJF0R5EC+ZxJxEEg3L3PaBYoeynBf1paQCvpdl
 iAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=E8TTnYt/tR9gTRuGjFqTZWOe/F8p33nz5wDsLlXM3eA=;
 fh=6iNmakO698nAyEze7EQZkGAKcKkZGLflACmRw2xLbpA=;
 b=hnD3X7Yt7E5itWXsy1Ss/Em3amfya1ljjMA74aKzYCgU4Ld3UDROdbNfuk17hX1UZQ
 wwzrvTGaH6565HgGuznQwr0G3zlCHUSg/IGhfoKi2UJnvj3vfb37ObHeiU8GqY6hlf8v
 z/2xU5s+/4xw9Y3hJAOs7j7MyksqRXzGoy205gwvvQSfALlJqw93UeVAxGBt5I7UGjnW
 ofkkKo7+XrIsHDsmje/tTHQ+Zd1Mrz5/nkLSlUNHkNHydfOZTrJJBsJ92YAezZRcuMsz
 3huvPdIR5HcM717Cf+YfwabBdd1KsiHsWfUiZjZPEBy8zjQLhIM+3u8T+ZwqIULwsN21
 uahg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772667086; x=1773271886; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E8TTnYt/tR9gTRuGjFqTZWOe/F8p33nz5wDsLlXM3eA=;
 b=a0QQlEHjse3556Q8zNCjMcAJQeU2NzhisXgqxNGk9wVH2KPVbNiALMpdlegrkTuwCk
 SijJ5I9UHlKlqYU/KYTmD9Wn36KyzzdhzHCgrnYPlXdZQFnPT2uSmbNqiC3cZqncAMMi
 Lw3ww2jJApMgdykT2m7YtkIcvv9orzX9zghUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772667086; x=1773271886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8TTnYt/tR9gTRuGjFqTZWOe/F8p33nz5wDsLlXM3eA=;
 b=uNeQPcWGQp6483elXXDyqeOVr0qWI1OXXTwZIy7lIygwTRXqReOwsC+csCltbtMvDc
 VUPdesB//80+0xfTK70zaazFWhoVTOu4qRJgBkVBggczNej9S1Rs7e2utlx0xZ+wd45I
 iARdJzW5GJoso76O0G+gaabfk/ohqxiKKl4HjnVYhr4/KEvh+YPtCeViRXX8iW94nYgU
 6hN07tOwYL1tuirblJl/rUM5EicRbXBXZTVgwCD0KofGW6njGDWCItVP9xMRgROz7cGp
 N06kbfSLPhIyJYMwQdKPNPvrkdG/NrtNXQTyBdzECtFZyRMRQuOkG83rhjxr8QsTU94y
 7wVA==
X-Gm-Message-State: AOJu0YxHeE9TDFW4KQwZMvxvGPPEpcLwyy0RPPAAxwM0AKjvr0zsUZ65
 px1AqBmMm+OQb+jbrL5hf2Ig34BuBHA4ZaB8fVkpkYECaTEv0US+x9E3CpJuVCK+6NsAUfuhSo0
 f9HuIV/sXW0xJaqJvHYscAGaOlbdb7A9zjXOHIqxvZlztlStQAk+/koyiPg==
X-Gm-Gg: ATEYQzzmAL/YZjcifig87loBsZQrSdcOoZMprA1PL5tKZ4IXZTM4Nc0fvoOedDfB9GX
 sf3cLADlh1Ll5CkPTWSJPIyEixiFmAv6Cq5wrCpv8UqsyJ0JwZDxjKPlihwvjsn23sq4dql8w9H
 TSCnnZGO1mpOhKJL9l9lQY5gl2Pe45wdFnVj+q36cNRLFseXWUjKBa9Klc5SpBq6emohxSZwP59
 0/6Q8kZ61RrYZ/Pf6vmml+ut2JWRienkcLqqqPv6eI/Td3Z2qWmH+wWC4zh8mUBmfzhg1Fytsvj
 wVNIRFAX8pnN9HMuM2QV21pQU637CDD8g4u9MFgpeYr07UidirSiz0Rmm6HVZUKJQANWbEEZ
X-Received: by 2002:a05:7022:6999:b0:11b:9386:8265 with SMTP id
 a92af1059eb24-128b70fd6d0mr1502619c88.42.1772667085484; Wed, 04 Mar 2026
 15:31:25 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 4 Mar 2026 18:28:28 -0500
X-Gm-Features: AaiRm52GbTdvbjE4K5ItAWF1N32mKLqUUh_m1H3wVA46NRvRwUEwHiWcXOFwmzw
Message-ID: <CAJvnSUCWGBeOeU5AQj4fPJCGv7FKMVzJc1hikC=31XUG4Ae-cQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - January 29, 2026
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

January 29, 2026

Attendees
* Patrick Robb
* Luca Vizzarro
* Matthew Labrecque

Minutes

General Discussion
* The release candidate 1 (RC1) date is 9 February 2026

Patch discussions
* Cryptodev testing:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D37138
   * Andrew working on v2
      * User to provide the dpdk-crypto-perf=E2=80=99s =E2=80=93devtype par=
ameter via
the tests_config.yaml
      * Extending test coverage to include:
         * Additional virtual devices
         * A greater matrix of ciphers, authentication algorithms, and devi=
ces
      * What about the vdev value which is set in the DTS config test_run.y=
aml?
         * What is does is it adds a vdev argument to EAL arguments in DTS
         * We would have a need for this if we needed to parameterize
any vdev values within testsuitse or broadly run DPDK apps (testpmd
etc.) with a particular vdev, but this is not a need/scenario for
testing we are aware of.
            * So, Andrew/Patrick to check in on this and most likely
remove the vdev value from test_run.yaml
* Flow offload testing:
   * Patrick reviewed, Dean to work on a new version
   * Noting that the new flow offload test takes about 15 minutes to
run due to the 1000+ rules to validate.
      * Patrick is asking for more protocol fieldparameters and
protocols to be added to the next version, so all else being equal
this will increase even further
      * Is this an issue? Is there a need to introduce a =E2=80=9Cfast test=
s=E2=80=9D
option to DTS where a user sets DTS to only run the quick tests
(basically everything other than flow offload and RSS tests)
         * https://bugs.dpdk.org/show_bug.cgi?id=3D1872
      * Should we maintain the =E2=80=9Cminimal-rule-set=E2=80=9D testsuite=
 (what is
on mainline right now) and add in this =E2=80=9Ccomprehensive-rule-set=E2=
=80=9D
testsuite that has a long execution time as separate testsuites, or
remove the minimal testsuite entirely.
      * What happens when the confidence check (send a non-matching
packet) =E2=80=9Cfails?=E2=80=9D Skipped testcase? Anything else?
      * What about asynchronous API? Is there a goal to add some
support for this in 26.07? Should we get started now?
* Can be merged:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D37136
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D36907
   * (requires final review)
https://patchwork.dpdk.org/project/dpdk/list/?series=3D36896

Bugzilla discussions
* N/A

Any other business
* Roadmap review: Looks pretty good, there are some items which are
=E2=80=9Csmall=E2=80=9D and we can toggle to soon when the big testsuites a=
re merged
to next-dts
   * There are also some medium sized bullets which we need to discuss
more imminently:
      * 1. Add support for producing code coverage reports from a DTS
testrun (so, show how much of the DPDK code the testsuites are
touching)
         * Raise this at the CI meeting next Thursday
      * 2. asynchronous API testing in flow offload testsuite(s)
* Next meeting is Feb 12, 2026

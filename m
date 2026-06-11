Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA37ECD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:30:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D552F40276;
	Thu, 11 Jun 2026 16:30:10 +0200 (CEST)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41]) by mails.dpdk.org (Postfix) with ESMTP id 744D040041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 16:30:09 +0200 (CEST)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-43ccd4f6f6eso5940624fac.0
 for <dev@dpdk.org>; Thu, 11 Jun 2026 07:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781188208; cv=none;
 d=google.com; s=arc-20240605;
 b=SmbeueDKxsIPOC0lzzA8ZTeQMNSQfmk4AQfHevoUam/3I7gG/sl4wAD4jaSECvUvrU
 nkF8/tna1+oH4XtZx8xaJ4sq0O/EcxzzngR5eaQNZIgs824aviLn7isIom6I6kfG4Yk8
 LFBmJjV2OFzVgdr9HnrbAKW/fvQCJQ01vtyTIXJzYCo3eirVKwu9/6cLpcN/Es7wCCTc
 pvx1GOP4tl2OrbeSilBB78nSbpby2dwL7mSyNfrWOT9f+Wv4u48dJCsF4hag6EtMwWC9
 w+Neh3L1TatPMqK2Kpt90jyYOZ5RyircIstoI8Wa119u2jBJNc8OHuT9ZedErX0RZaCJ
 MIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=o8GXblckLA5q9m4H+kQnfbt9chaNOscTgVuP9300ccs=;
 fh=SmeAyABM4rfT32CZ90spRvJxp9TgPXvzIvi7t3j/5Mk=;
 b=jZv/N8zL6M9ptBYtObP/RR24gpDr6BsmvmWBLTnq86S1bbJvMvBFuVH+rGuggUsDEb
 GU1TD3eut2jIW/H8N9Sel8WdN1/fzV719Ev+60LPweKYROidsnZKe27lrZj+P1AW5ofH
 uADlkGUovWHjlJIYFtSeVSzA4sM3pebHRtarJVu1UR64JJ48reiFTGBlBXBb9oCtfI6m
 atZBMJgUAjAEvdhkEV48ESfHkxO46PwpEEwjhAeE6HtHAR8Sg1kYX5WrmJGeRzyD7sAX
 O34YIuIfysG/a5DPX7XrhDrHSGPmkx8952+KEoGu+ArYqzOPgBRYcwGIfuGWNHsaXcAP
 0I7g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781188208; x=1781793008; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=o8GXblckLA5q9m4H+kQnfbt9chaNOscTgVuP9300ccs=;
 b=EaqaFj+NpeA1V5YaBDpOIP0rTSiR96RwzKoeFr+DxyC/pZpYPxnO8K+45x7AXhwWHq
 pOPbejdMxeu+dLZ5y8qfAbAAZhvllni0z9+ZptB4a73MzRq2e3qtfQazHjN1gwFPXanp
 Y9G25ZlM4PZLk2VwvIYhrl3tnuEAQ7lRoeulE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781188208; x=1781793008;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o8GXblckLA5q9m4H+kQnfbt9chaNOscTgVuP9300ccs=;
 b=nh9VgIFSBIEfbRgmU86a36qfd9lz7CB/NX0T8Vj0p87iO3HpEnfDSqhoW4CS40+x/L
 2SekILIFH+5sbO9ZqfzAJtzWXz7nh5x+U/jvwdhJfbR5tY3QQOZaC8lbGyeqtcCh/E2u
 qJ0rtDdi1PGeN+/IZ4MIcbTo3ILpeG6oAWGgLUYIskSjzzqEebaCD0nn29db4UHU9rag
 sKhy0xLozAWhrpHFJJN22JqVLorxKwqfx8mRsyn4sFQiikY+A4NbeUat49+8OysXthsk
 i5FdG2lcm8XC8+iEeyU7GV/fJqmsEPOLzF9EA418eceWitXLiXRkLymChwvBlstXRKYh
 bCRg==
X-Gm-Message-State: AOJu0YyxIFgN9RF/+Nhtf28cPZrsjtK8LFzBlaB7BLEEQw8Cg06S5no9
 SCdlKnV6Tp/dnwwGM7/KZW8hyTsrCPwrJn6S2qN2X0Duogp4afcT9E0z17RiUPDXrsD5oyGMMob
 S8Fl0aduNFgygx33ubCRdTidYTLmIHaUPD0/JbMG1LihsG1wZ/ir5Ots=
X-Gm-Gg: Acq92OHgIVeHSyMgZcuvgMvdXlI0QXZjQgiJz8uhlRlVnwXFRdELZwjEvjmqkksqgvd
 B5/00sB4ZQ69CBky7OxgChcn84yIfT2nTXozKrDOa1qZKPx/dyzGkmplWbkSuZli011PSDJpNBT
 VtCCkzFstilD2VjqUqV84Hm8P+MHF9A6ozypxUpowErjqYgwFrgW7QK6JGxQyJS0ay2WCS95UXY
 IdAqPEl39WjLasd5vkQ78rtkWYOACu1NI3oiE0Mn55qXZ9rrFEIN8GDDEGk0LWKMFmImF58yreH
 onLUzL7OK5iM5iCdQ/xAN4HKfdR3a/Lr9aHWhj7ANCmkNaz/eeo=
X-Received: by 2002:a05:6871:3313:b0:423:9219:4c6 with SMTP id
 586e51a60fabf-4424195c681mr1880988fac.13.1781188208466; Thu, 11 Jun 2026
 07:30:08 -0700 (PDT)
MIME-Version: 1.0
From: Lincoln Lavoie <lylavoie@iol.unh.edu>
Date: Thu, 11 Jun 2026 10:29:57 -0400
X-Gm-Features: AVVi8CeBpirogyyMksH-btfX-vLqletAXkciVa5NLQ2bzb2tGReCjBWQGApHwxc
Message-ID: <CAOE1vsNCkhZ8q7ieRAGbJZTFg+xUsjBXXOmegXdoG6L24-Y2HQ@mail.gmail.com>
Subject: DTS code coverage question
To: dev <dev@dpdk.org>
Content-Type: text/plain; charset="UTF-8"
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

Hello All,

We have a patch into the 26.07 release that will enable generating
code coverage reports when DTS is run. The community lab can then
generate coverage reports, like we do for unit testing
(https://lab.dpdk.org/results/dashboard/code-coverage).

The question is, with DTS, tests can run on combinations of NICs, etc.
So how should those be factored into the reporting.  We can do 1 of
the following:

Option 1: Collect coverage reports per NIC / PMD
Option 2: Aggregate (combine) reports from multiple NICs / PMDs into a
single report
Option 3: Only run it on one NIC / PMD, assuming specific PMDs don't
change the coverage much.

Is there a specific direction the community would prefer?

Cheers,
Lincoln
-- 
Lincoln Lavoie
Principal Engineer, Broadband Technologies
21 Madbury Rd., Ste. 100, Durham, NH 03824
lylavoie@iol.unh.edu
https://www.iol.unh.edu
+1-603-674-2755 (m)

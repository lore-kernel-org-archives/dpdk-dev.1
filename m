Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70024D37E33
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 13:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13FEC40616;
	Wed, 14 Jan 2026 14:39:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 78571400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 14:39:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768397983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=p4QI/jinEnbFwBBNTw9/MIPXk9vJlC7XQE8LH1qKUdk=;
 b=EI7kktYuVn0fDUoilL7P4Jfj69HwS1Hb4uA2sYo8nzyPWQqf3Un4btfKEGPXFNUDVGoVGa
 rSmCltq/JgK0gnilAIJThj3MkiFL3GAKK52CNrM7PKhNOKFgPeXAB0c9jO0+cJui+K0RP5
 7ipABPO58a6Y3LSylqb+wxRc8xQDDnk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-ljRqNxEgMrGrV7HWtqa4sA-1; Wed, 14 Jan 2026 08:39:40 -0500
X-MC-Unique: ljRqNxEgMrGrV7HWtqa4sA-1
X-Mimecast-MFC-AGG-ID: ljRqNxEgMrGrV7HWtqa4sA_1768397979
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-59b6a97e566so6397505e87.1
 for <dev@dpdk.org>; Wed, 14 Jan 2026 05:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768397978; x=1769002778;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4QI/jinEnbFwBBNTw9/MIPXk9vJlC7XQE8LH1qKUdk=;
 b=lx94IrqWY77cKQM3FmrlNPMhDXIUAXsa5PMawNcdJhGo1i8ogl2wfpJT8RPRBKPzxi
 78ks0yEiGxW/B5bPn0ZYf66EKX6i0p96WAF/UGvzKgGl98ee52eKO4vPwyTUJ1+coTv7
 6WwpRd7lawqCHsis3cyororMVg9yBk4LvoaK9LeSpGTnapt4hkDr8wUoKPCovPY5rmne
 5wX4D7HjE4AxZq1NNW/KiBuUt4brqm4BrfYm7KMgqeZ3pYebgaNYYwfD5RLT2n7kEUtL
 gSqtIKi0hZCzc4RY0BGyCgaDqLkyb3dtvCwaXDEdHaQmgSTubMwu4MUusYOZIrbjruHo
 RNlQ==
X-Gm-Message-State: AOJu0YyRoMyN/c/eeEb9VYoLz8lCVQx9h8WGi+Sk6K5KDOVqD91mfZAQ
 AGcMNgfdr3MDTgqROKKjcqNotiex127fcNhs7RRudUfcUWNmXze59jewWxx0Ad1rmPsJ2ce0Idx
 2P8AfqCLC2Utm8L9rOMIYr4ypQ+frntF5CDdC3B1wp6c0NsknBYADoYBeWcOotJao1fwfqso/i6
 iAORPDHIU2NWjCvrb09zTFEkFbU0BnnQ==
X-Gm-Gg: AY/fxX5zKGOGslWj0qkk34XheV+M2cL0l2CmFURamCVuWHEfBp1BuT22l2ET2ceRelh
 YCkkIvL/wyt/byssWL5pRaTFdCJW7mzCuJJCfEOH9YJcB3AcdrQrFB/NwHc62YfeP1ACRMXSoRs
 XWuus2pkN/naO0R2Dw1hx1hkHHpP0+ArRslawRP3ztlD9GbC2QucCIEHaI4GBkBdC++E+q9m6t5
 77VAcmR4w+NWCmBwIOeNIStir7Xq6A9WAnfO9DBhnsV8ZtRe57Agg==
X-Received: by 2002:a05:6512:3da4:b0:59b:9f92:301f with SMTP id
 2adb3069b0e04-59ba0f5e230mr990591e87.7.1768397978237; 
 Wed, 14 Jan 2026 05:39:38 -0800 (PST)
X-Received: by 2002:a05:6512:3da4:b0:59b:9f92:301f with SMTP id
 2adb3069b0e04-59ba0f5e230mr990580e87.7.1768397977752; Wed, 14 Jan 2026
 05:39:37 -0800 (PST)
MIME-Version: 1.0
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 14 Jan 2026 14:39:26 +0100
X-Gm-Features: AZwV_Qh6gPl7BnmazldFtLCIWzIo7M3Mg3SobDrnxYBFDC12Okl3b1X3HLWybJM
Message-ID: <CAO55csybhfSRXkwR9mihBtthO-YGs9ZefNw2_HAZK+iTikWu4A@mail.gmail.com>
Subject: Technical board meeting minutes - 2026/01/07
To: dev <dev@dpdk.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sXs5k_-EFIWqziPTpEZp9pEUad-_6xwyhsMJOLh-ruU_1768397979
X-Mimecast-Originator: redhat.com
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

Attendees:
========
Maxime Coquelin (Chair)
Thomas Monjalon
Stephen Hemminger
Bruce Richardson
Hemant Agrawal
Kevin Traynor
Aaron Conole

Topics:
======
* AI review bot (Aaron)
 - Coderabbit and Sourcery are not gaining attention. Initial
experience with CodeRabbit was mixed
 - Aaron experimented with Claude Sonnet, which performed
significantly better in code review.
  * The bot was run on a patch series submitted by Stephen.
  * Need to identify other patch series to run the bot on for testing.
  * Tokens are currently being paid for by Aaron.
 - Thomas mentioned that AI credits funding from the project was
requested and already approved (estimated $100 per month).
  * Thomas will create the account.
  * Nathan to provide a pre-paid credit card.
 - Next Step: Aaron will send the script used for running the AI
review bot to the Techboard.

* Thomas reminds Techboard members to send missing meetings minutes

* DPDK Summit 2026: May 12th to 13th in Stockholm


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72942CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 05:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32B8640674;
	Thu,  6 Nov 2025 06:02:15 +0100 (CET)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mails.dpdk.org (Postfix) with ESMTP id 47C124013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 06:02:13 +0100 (CET)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-793021f348fso506202b3a.1
 for <dev@dpdk.org>; Wed, 05 Nov 2025 21:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1762405332; x=1763010132; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TiflBG1bcE6TZ81E84z2+XWhGFnzRz2yFqOisHXpNNA=;
 b=CqX+TVm1/j39UPamhAgmqrvS3J8tJrOv843KTSSi3jC6iYT2fCOg95cMi/eaNsDD+f
 NSJvgI+ByuAg/V2ifAzib7fKXWClCk4VzRPnz4R0yXQwacK1GwS9r3NIeALcdyxD7N2m
 LTTx2QXBBo9v6exy1Bq2yGsizZZSJiG8eDHiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762405332; x=1763010132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TiflBG1bcE6TZ81E84z2+XWhGFnzRz2yFqOisHXpNNA=;
 b=RKTA0KtRJMRj7i8SdZNNE0JJHr/01n/k6P7XFjlTdM5dm0QrbJLTYFQq1n46WQfCF9
 t2ftS8YnoOBrVQyhKRfnfOXLvRGpX/voImWGPyIR8DeWoMZatRntoYP35krtajEAUKqw
 CkRp6reL09uIZOM7Lh0odPUHgN1KRnCUzLl/T6WsgpTFcVhZtqxuZvqcRC9O8OrDT/y9
 QWKK/R/V9eu4Kbpd2VCdvLEZ/S1Nk4b9NSmv4F79DQyGhZj8ly7GUaoBFdQDn1oAHdGR
 eEoCp2inHAK7mKgjcMvIWqNIwbDM1w/JjEutfOAKiYYfXhJWa1Fg6Z1rpHUnE53KCCdW
 BrLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTu55b4orOeBjeS7V1nQqbrxjNjYs0MWvTgoFetiHT1IiuTNmV1wcBsFqIl9IOfVBCHcw=@dpdk.org
X-Gm-Message-State: AOJu0Ywnu4vJZXFGxtLDCRDvFI2dsRJJGrcv8h3Mrgtc6pJRsRMkBtUj
 DuVSyiNhdmHVEBoPJ/K6sLCcCcPYCkkKCuseqYyAUiNOm2O4jscYvlcL0R9l8S9xVVnOFqTh4p3
 1+LyBBHpt4pDllrd67ce5wxNmis4T5WKNI7bSiAecHQ==
X-Gm-Gg: ASbGncvV/aBvl0zKOJ/rYDSomwFVS58AWtAyDcilGG7MPx4LKB1djCYvbAE16NUuNxu
 FBHxbOOpU/XpxtV8sHfbOpAb94vhPatDa1rsBmOmGUBFIcXqrVrVOLglXmln9PRlj754skLzJlM
 6TcWsOAo3wA9MzOjyMq0lnrR6PN1PtUapOTGkLSx0YRj3ngVBhtYm+EcLGIoCXTqh2u4ssLW8vX
 1KPcQY9eI8BE88Q45cEs1pwkaXmnewrdvNIf2HFxhsb23DJb4mbUVy9MlS9yR0OoB8G5FzBCRn8
 f99QZO2F3SA=
X-Google-Smtp-Source: AGHT+IH/wB6/tX88urdclKLV1KS7y8dyuY+Eaq1YEePzogy7zfrTQpLGX4x4Yz2JV1tDABD4VUfpgZpdTnhum5by5Vs=
X-Received: by 2002:a05:6300:218c:b0:34e:63bd:81b6 with SMTP id
 adf61e73a8af0-34f865ff9f0mr8086433637.57.1762405332375; Wed, 05 Nov 2025
 21:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20251030125231.114295-1-paul.szczepanek@arm.com>
 <CABD7UXMZ-5Mt+TzGOYWaGebBzSFr8P9RjkWDJ2U=7XwQZfBPEQ@mail.gmail.com>
In-Reply-To: <CABD7UXMZ-5Mt+TzGOYWaGebBzSFr8P9RjkWDJ2U=7XwQZfBPEQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 6 Nov 2025 00:01:03 -0500
X-Gm-Features: AWmQ_bmnw2Si0qHiAb-OVPDOh5T1XB2f7GSFFyNvtU1ymXYz9tm5NaDlFtUELwg
Message-ID: <CAJvnSUBDw=ghm0yMDKFEF84_TcU7ES9dCd32xqHVd7xO9EpNzg@mail.gmail.com>
Subject: Re: [PATCH v1] dts: move artifact class to API
To: Dean Marx <dmarx@iol.unh.edu>
Cc: Paul Szczepanek <paul.szczepanek@arm.com>, dev@dpdk.org, 
 Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000c96eba0642e5f774"
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

--000000000000c96eba0642e5f774
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000c96eba0642e5f774
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000c96eba0642e5f774--

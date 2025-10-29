Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623BACCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A8B34065F;
	Wed, 29 Oct 2025 17:31:09 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 38EFA40657
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761755467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=Gf7i2G0P0lc4MZ46KxCBup+4+0+TQzUACnBIbHWCTck=;
 b=HqdoACpnexUgmQJlwAS8V1U3t9WFotvjtYTJ/6mGbZKOCCzQ4c7MuUz9T41Vt1cPXqWY7z
 yMwYOQTjB/45hICJHLVcfw7s4tFHeaAgsb5wLxg4ud1tU26L9VIQQRVIMoWotnLb/xkanR
 EGLPcNdA+QXC9MyWQzM2MW5Mg7SG9Kw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-nfTsiszePHOK3PeFHPvD0w-1; Wed, 29 Oct 2025 12:31:06 -0400
X-MC-Unique: nfTsiszePHOK3PeFHPvD0w-1
X-Mimecast-MFC-AGG-ID: nfTsiszePHOK3PeFHPvD0w_1761755465
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477171bbf51so9017005e9.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761755462; x=1762360262;
 h=content-transfer-encoding:subject:to:autocrypt:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gf7i2G0P0lc4MZ46KxCBup+4+0+TQzUACnBIbHWCTck=;
 b=PmVkOgBV4HqvNxKHnZXk9TC4FaDS5/cHVWr7lpgfSmbC2IWqfMJMWimE7qddpbc254
 TS0gdQrIk5YX2BruazhTF+hwfM13V3UFIRZanoVjPKyN3NZh1+LNavnKmisPrSw61gY9
 ZHUhlZCIc19Qe6clP8dqbqS0SP7ev5pJ+Ui5mu/QNe37ZlfofREoTP8aydjH1SOziNRn
 klVnpA7p16K/R3O0rO/AOfJvnfJNl/H8AUIvu1RXY3nn/XuMIrUhfbqmGgXKg6Wwtg/r
 NC0zcXsfbMChuwLsJ2P39Tlz7spft1n52Jv63dwY9FnCR6L8WgpBbL76utMAsC7lbgG/
 RVFw==
X-Gm-Message-State: AOJu0Yykdwyev9M4GZL5qXnTM3rqrsPOgMr84l1CKYFnQWg4QI2WZLmg
 TfODHIBHBabIapPBiSF1XKrZQ9sPb5tAIKMEWJcEHzCHd/w6PMJBl1kUf+Erqjk2X5eYEhxvtsh
 tz67Z8qEOf7neY9smmOBCEaMOOMA8ZUwp0tajk6Sk0a78Lf4xVI14glOhCbJboLwEFOsMXXZ8sl
 ui0kNHx6ZDggjwD3tkehqiX+B0l4yp
X-Gm-Gg: ASbGncvPoINPSwKAA8V9ox/c21A6tfLrI9al19KPNY+qbB1AJVwKRYZNIt5TJl9QY7l
 KwRxfnonf+Ph83rRDm8sNt/GC2bOnVPXuSFjYAO1Xy+z8UsAEnNrW7kehXJf40euhrWKut54LUp
 9e7l6IJkl2hO8rb0+13hDk1+jqI/vmIBDFbAAb/wnSvniS7A5MeTFvPErO6HP1qwM8WNi7efTPz
 X5u1Uff/8zNyGJ86Z0FtN1ri4reG39z3684Qxv6brWOSOlA+EIYqHxpmEGsTM+G0i0gUhEw2/BM
 n4B8TtuvoSXLBjgSOO41KFhIVxucafKMvEUHhUXy3DNEekF1AEmO2s7lWIdCGMc6OSi40yLHaRP
 HLg==
X-Received: by 2002:a05:600d:8307:b0:46f:b43a:aef2 with SMTP id
 5b1f17b1804b1-47722c8d725mr12826155e9.38.1761755462147; 
 Wed, 29 Oct 2025 09:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4g/UUWoHT7MZJVi/8gsBErkpIU6lbVAmw8JM5O8UhD7bB/0iUjynG/l5H0+RCAwLuRrLx3g==
X-Received: by 2002:a05:600d:8307:b0:46f:b43a:aef2 with SMTP id
 5b1f17b1804b1-47722c8d725mr12825955e9.38.1761755461543; 
 Wed, 29 Oct 2025 09:31:01 -0700 (PDT)
Received: from [192.168.0.56] ([78.16.131.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b79cbsm27265269f8f.4.2025.10.29.09.31.00
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:31:00 -0700 (PDT)
Message-ID: <356e655f-582d-4f67-8a36-c6284ec7c2d5@redhat.com>
Date: Wed, 29 Oct 2025 16:30:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
To: "dev@dpdk.org" <dev@dpdk.org>
Subject: New LTS maintainer?
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QLYjCAPqu5ER28vofUSht_cNSCdYBqnCLnMvj3SkAbk_1761755465
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi All,

tl;dr we are looking for a new LTS maintainer.

We have 3 maintained LTS releases and a maintainer responsible for each
one as listed at https://core.dpdk.org/roadmap/#stable .

Xueming has done a great job maintaining 23.11 LTS up to now but is
stepping down as maintainer due to changing work priorities, so we are
looking for a new LTS maintainer to take over 23.11 for it's final year
and a bit.

The main items the role involves:
- Getting a list of fixes from main branch that should be backported to
the LTS branch around time of a new DPDK release
- Backporting the fixes to the LTS branch
- Resolving any trivial conflicts (and complex ones if you want)
- Notifying authors of fixes that could not be backported and
require their assistance
- Notifying authors of fixes that are queued to merge
- Ensuring that CI's are kept green
- Creating release candidates for the validation teams
- Working with validation teams and authors to get a resolution for any
issues that are found during testing
- Writing up release notes etc. and releasing

We have many scripts and tricks to help semi-automate the steps above.

Luca and I will continue as LTS maintainers so we'll be available to
help someone ramp up and only a ping away for any issues.

If anyone is interested please send me a private email reply by Nov 7th
and we'll propose candidates to the techboard.

thanks,
Kevin and Luca.


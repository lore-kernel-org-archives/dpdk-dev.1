Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D5CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 17:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2021D40262;
	Wed, 22 Oct 2025 19:30:34 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id A7A794025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 19:30:32 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-27ee41e074dso84098465ad.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761154232; x=1761759032; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7r8hAEP9XJk/e0dLulSc6FSZfItwP1AxWzSStGq1tW8=;
 b=jpgJGvZNQR5ZD5+MHWCFfqICO1zOssanlkiSYf3i4GXLoaA/HH7I8F2vH676AnV4jL
 F0J0ujcgPjN22XCJXVdU5ZGvDGypzbxbCRPUocEXStKXy9zSCsbVJdagAMUiWaCNth32
 Pq6KZN5S4znf6/NX79ehVvzJCHPdgKPa4yEM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761154232; x=1761759032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7r8hAEP9XJk/e0dLulSc6FSZfItwP1AxWzSStGq1tW8=;
 b=CovaBkI//PTOOlnLzNUd3XybDCrMQIRltO3xwYEsMb6GNuOSwA98fljclrdSCIP05R
 31NS/4+IgUcpfsubTU0JLOTfPR88qWKk0UyBq8icm8XUa4J/DZS0/Dq7fGGUv2SAgWB8
 CeStWINjsJl6NIcsFy6axAdsjyLKBDGOhqUuI8A+fwIsgivw82IGXCb8lfYOhqOeinyT
 QPkiOHJwlTKmU+RBtt2K28KnoWfUr7cXVAFy6mdovIcHNH7ifxPiQjvykUbAYar5CrM2
 E4pBxpistnDT158ac9awcDoLwyeWDD/TO2zHDGwev/SwwwZZ0Mgce0qC0evQMHWUTkT7
 PAgA==
X-Gm-Message-State: AOJu0YzRc8W71xzWpCW5tX7C/KQ55qcl9KrqWvZGqclNu0DB8MuV1D1z
 dwZqNWJIpFReOmEtbVasfatvSmj0LD6uYmiGLYMwUCfnqcsXDYf6OMk+QAnhOh5Fk2ehubQ2KsH
 wVnLo/lf3Hjh32NWTFQQC5tUJ62+GwBJqlOdaaK7fwg==
X-Gm-Gg: ASbGncvq7emdyV6LysKJwQ1AJQahYhZMhQBONS66f5s6q2p+pwlW/+LKAAcnYyfSyL0
 YQjHupBqUiJ+m2kCGb0TrjSzkFdLn0qy6jSQU8RcC5SoJS+cyGU7LzragNsf5ECjdwUueQIax1v
 A2OcE1bqUbbO3+LElkTtyo/zmsph2NNSnjy3hUHHc1X03InQfcJcj3JaXo/iZ1fMCBi71Mi9vSi
 0cZigg12TnaDhPkSF9O/sDjEmU5bcTOqdpKfCEGomw/MOA4e+L0CV1hmN86H5Asxu70dVSrWWq4
 v/0VaJ58VU8mC4b/84TgkQlPcLj0
X-Google-Smtp-Source: AGHT+IGZNGfIe1bAZZ1gYuw8hB6BbRrOCaK4vi4nwwjjqYhBYvrXsW5mDutwu9fWoRHEwsmdsmfuJNbH4zvbeOjnlTc=
X-Received: by 2002:a17:902:e5c8:b0:27d:6777:2833 with SMTP id
 d9443c01a7336-290cb18415emr297585905ad.47.1761154231427; Wed, 22 Oct 2025
 10:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <250811213632.16023-1-stephen@networkplumber.org>
 <20251019165728.164929-1-stephen@networkplumber.org>
In-Reply-To: <20251019165728.164929-1-stephen@networkplumber.org>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 22 Oct 2025 13:29:39 -0400
X-Gm-Features: AS18NWBRbBxCisyesUBElUvDNqbFhKC7oH4Uybw03iMzBBOXwpCTKh3ggtv9aoE
Message-ID: <CAJvnSUCqKffbMP_aB2MevhBVRL1NwO4n6XTUYopFcLizHmVdOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] packet capture bugfix and improvements
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000005bf86e0641c2ac6e"
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

--0000000000005bf86e0641c2ac6e
Content-Type: text/plain; charset="UTF-8"

This email is triggering a rerun of testing at the DPDK Community Lab for
this patchseries.

Recheck-request: iol-intel-Functional

--0000000000005bf86e0641c2ac6e
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">This email is triggering a rerun of testing at the DPDK Community Lab for this patchseries.<br><br>Recheck-request: iol-intel-Functional</div>

--0000000000005bf86e0641c2ac6e--

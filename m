Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6174C19F32
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Mar 2025 03:03:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43D56402F0;
	Thu,  6 Mar 2025 04:03:42 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 68E1D402A0
 for <dev@dpdk.org>; Thu,  6 Mar 2025 04:03:41 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2fe98d173daso307294a91.1
 for <dev@dpdk.org>; Wed, 05 Mar 2025 19:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741230220; x=1741835020; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GV7JS0H7yZ7JrNmUjBWz8m6j0s8w6yCKlXmbi43T79Y=;
 b=jBmFFnLhiSbB4jIJXXYJcFs84SkOI2ALaVlDsApqp3jz7jsh2WR+GNSmqxWx2637L6
 V9Ps1XbN2njSxJ0yT8Q16u8/YPWomn/MGR53eBG1ESpzZLEUphC/Dp79+DhIVq2fmmSU
 tR8gHYcmZVKWb19warBpOmMJ7fhrdtZrZqtC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741230220; x=1741835020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GV7JS0H7yZ7JrNmUjBWz8m6j0s8w6yCKlXmbi43T79Y=;
 b=DFLOHfOu7gkIdlPdmSKgiF4+q6m8QWGLT6G+T2ap5NgVGR4Wzu+i2GF9pz4hrbd1YQ
 SxL56ds4hleZ8lktj+iD/uRsTGnalfdcF7F7X2GyKudkrO3M8EJD0COuwK1vs3XsLm9+
 ihOx+U/+SJktf7cwCm2QMJgfI+59FREkLTe65zCvISvMXPZoxRcc7BgdB3ZD0jq1OgM+
 27RAGUsCkJpSuQWmwslVflq97bVlOW8jtL6RkbP+wxqOZG1/LZlOGtvT1i3wB26V4Rvk
 ncNbCZvho6pmByCtPE6JFw6/5+hMLbpLGwmsvQCbELeEERm4IgJGHMNfvyzRMjpnNj5a
 2YIQ==
X-Gm-Message-State: AOJu0Yy7h1wOmUGE9fjG2yHKP8WZuncUovSSkyE8wDYEZaKt1OvC/mCH
 PssqcsAV3nDq7keFxNh9F7WAGxgQKaspZ/4v1Tnb8KbT4ULRp59hjUMHtVOOx229XAahSg0mUFY
 JgHSs8X1DBOvvj7YyOVe3E0ZT1T4Z4U4SV9UVpSF9ht7wCZI5fzhSnQ==
X-Gm-Gg: ASbGncuAYBKsFNIW/yOanuoiAwjo0sL1vibxJ3WMme6mx5TYaACVAqgkQm+0BqFALF1
 1BTqn377QWIYHYYx8qarP4pEvNErGV1PD0D6PaRuGN28t6OS8KkKHeM61Xa7NM+SO2xOv0OxduM
 jercvlm1qfwsqimZnzxtSfvXGP+1sx1vNgF5pqPxIwvA==
X-Google-Smtp-Source: AGHT+IGtZxzGmK1leJNYEslYbkH5I7e0rxw6i5reSFt5eAFF9TSOiVO1w0JT+Wluu5z6WWnVTdu3v3KGGeZPRvBX85A=
X-Received: by 2002:a17:90b:3f06:b0:2f5:88bb:118 with SMTP id
 98e67ed59e1d1-2ff497eb7a6mr7626618a91.22.1741230220540; Wed, 05 Mar 2025
 19:03:40 -0800 (PST)
MIME-Version: 1.0
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-6-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1741192690-26243-6-git-send-email-andremue@linux.microsoft.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 5 Mar 2025 22:00:05 -0500
X-Gm-Features: AQ5f1JpJEC08_dgWDumwPRRlpWXRiFAzor2upy3Wtj-SuM6hm7pCW68yk_ZTWAk
Message-ID: <CAJvnSUBEVxj-ATsUuw21iRQg55PNPZURHgBjgUbORsEBjoqr8w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] app/test: add tests for portable version of
 __builtin_add_overflow
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, mb@smartsharesystems.com
Content-Type: multipart/alternative; boundary="000000000000c495d5062fa3c0c5"
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

--000000000000c495d5062fa3c0c5
Content-Type: text/plain; charset="UTF-8"

Recheck-request: iol-intel-Performance

There was an infra failure with the Arm Grace server about 12 hours ago
which caused this failure - sending a retest request.

--000000000000c495d5062fa3c0c5
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Recheck-request: iol-intel-Performance<br><br></div>There was an infra failure with the Arm Grace server about 12 hours ago which caused this failure - sending a retest request.</div>

--000000000000c495d5062fa3c0c5--

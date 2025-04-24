Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B011C369AB
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Apr 2025 12:31:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0ACC400D7;
	Thu, 24 Apr 2025 14:31:16 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id BAA55400D5
 for <dev@dpdk.org>; Thu, 24 Apr 2025 14:31:15 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-af5085f7861so618724a12.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745497875; x=1746102675; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jX8Ml8Hf5D1vWoQeTAoY6qC9qpqL3YGHOFNdspNK78Y=;
 b=bKsL2IS7UCVyfAvC2a1AjOFEmWo8GIRENnAK8ZHZ4nyM+Kg4XXZVbqKL/WIa395C80
 LYTHwNPsruB3Qd9R0KzcshPHCHJC7Bb9ZgD1U8PzgmuuypXbuadxUUH2qUCRTozuGc61
 pProF31X7Bqhm1tJ1tnZgX6vonNOezfkH45HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745497875; x=1746102675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jX8Ml8Hf5D1vWoQeTAoY6qC9qpqL3YGHOFNdspNK78Y=;
 b=UZmueXQYXv7W/BMkAztIxsQ2HMq90U6q+XbP0RBRe0hNlz1Zu0yEBWH285WlBBwOz6
 HloPs3C1Mw90nhhlRN0Xg4bQI7pujwy5y12t/+ITBVQCDClmYkIL1Zv4zfOaxO27m07/
 ONUZvR+51BzHFss3MA9HCB8O7fMSsSXuv6WftgFO0fLd7l1S3UHtSeYlDxwaeCaoCIsj
 gpjo6147EEXpE1qxy+cWEGKhTPxcG6h9XiqK8OEwX/vWbyawPEl4uRvEKjSno7OxwV3i
 Rz+GowFDQw5xgiloh7abaFyfmmdxT993wM07en+sDOsjeLKwOqxBBHYayQaA6nwpcmE2
 qG7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW38uqGTjRI/gv2mrZUbfwoXe3ZTXniCyGkl0jnzkEkPtj+HBcOGLNIcqG0x89P3ueTtpo=@dpdk.org
X-Gm-Message-State: AOJu0Yx0md1itwFaCxuM7stoARU65KkXd/1KVzAJBzsg4qMaDZSXXjrD
 CfJYnpwEhv9xPenwlm8kRqrNprFIPevGaqpAjZ6fJXYNu8XYFeXavk4ljjokWVRZvwePKHIDmPU
 TZlJxj8zx05fMYo365RFddA+1kTltxKklNdwQaw==
X-Gm-Gg: ASbGncsBKQfQPQh8TZxtpZaVILXFKtd7VrQtSkY2+ryaz65RycZhpWoOIMgwzhsjl9O
 1XFO8DfMddgiYk81t7uhg9ko7c7FeeIK1sRi/UJXfsrbvjNaU2PyVG4EB1f0mNEoYYossKu9aqq
 STj1NPAHpG63bd2W7j0NtVqhjEyGn86Xz48ypUmRZuNf60hc60YRrLC4oTLp4ELbBVYw==
X-Google-Smtp-Source: AGHT+IEG/dBQkbCWYniFMv44CBmwRu7vmDkcuHtSjBvEnFv5edyOjiGKeCR9dCoppzspjfoks7j71e/o7i2dPLv2axQ=
X-Received: by 2002:a17:90b:2f0c:b0:2ff:4bac:6fbf with SMTP id
 98e67ed59e1d1-309ed26ac20mr4000083a91.7.1745497874774; Thu, 24 Apr 2025
 05:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240923154936.15952-1-jspewock@iol.unh.edu>
 <20250220212443.66483-1-dmarx@iol.unh.edu>
 <20250220212443.66483-3-dmarx@iol.unh.edu>
 <CAJvnSUAKsM9DbdrPWr5UYv_Zn28dnkAEGKhpmjYmwBjbHJ8-8w@mail.gmail.com>
In-Reply-To: <CAJvnSUAKsM9DbdrPWr5UYv_Zn28dnkAEGKhpmjYmwBjbHJ8-8w@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 08:26:52 -0400
X-Gm-Features: ATxdqUGX_orukttj0-x3esD8LH58uCXPZsno6HR8OC9O0-NAk7r-7xIbcV1Avcc
Message-ID: <CAJvnSUAvo-fCGYORze3jfUaw=r4AkAmcPT1dtE124v2p9ybuvg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add port stats checks test suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: npratte@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c85a9d0633856451"
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

--000000000000c85a9d0633856451
Content-Type: text/plain; charset="UTF-8"

Applied to next-net, thanks.

>

--000000000000c85a9d0633856451
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Applied to next-net, thanks.</div><div class="gmail_quote gmail_quote_container"><blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div>

--000000000000c85a9d0633856451--

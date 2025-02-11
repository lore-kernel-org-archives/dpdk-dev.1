Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2404C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 20:27:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05FE7409FA;
	Tue, 11 Feb 2025 21:27:01 +0100 (CET)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
 [209.85.219.174])
 by mails.dpdk.org (Postfix) with ESMTP id 71EE24027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 21:26:59 +0100 (CET)
Received: by mail-yb1-f174.google.com with SMTP id
 3f1490d57ef6-e5b1837d182so155713276.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 12:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739305619; x=1739910419; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jqm7011p8VclE3nwioj0iiqA5Q2NjCdkFc7MTaou88A=;
 b=EoK8FQBPhVRxlWRv2mrFBi9o5WiltLliujeQUB0cY74XmFdfBXyr4qzk7/2yZ+43fR
 B8BAk3AW98HHhMzF3cX7OVj9iA9otRyBDDoxnOtZhCm8WNSHL1FW9VJSpuRsS+8kYdiB
 YH9TmAKk5ttyXdPlLSe5t05exNXC6s8PbHgOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739305619; x=1739910419;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jqm7011p8VclE3nwioj0iiqA5Q2NjCdkFc7MTaou88A=;
 b=ER8+712J14S9qa7ejZ9s/k0fXKjVjJ6R47xPEN6IO7FkDLvmuC9czEGC+S66n5/Kzp
 tJ5nlL36xj9aUnkB2XKiNyv13sETPenJ4XQWBGr4vi5As9bIYUYCgP99pmMNnyI2TN9M
 ff+emI+M3V05RuXGhreL4ZyvF7i/nkG/UI2DaaFptlxBGkuF7SKrCAWZvTnYYkJZwI7t
 HBoiyM+Aocf9zwCeUL4kN95r9GHBVAYNt8dSL7jENrTan+xoVHNWVB28LkBObc6us8lb
 k7NoKyzlfOZzsIqUxpA6iKKy3FdAnKmtmZnJiprH68wr1XKI2/d2RepNfPQMXceDtGkU
 2gqA==
X-Gm-Message-State: AOJu0YxhmsQy8hbFTK+agogkylNUWDs5G2kSolNs/D6fKzXG8QZaTJjh
 XLIEQd1NceB95ke5cDFDMXLQQsAsCzdajgPzIZTGDeHhY1F9/hGsDNoF4ymDuzHM432d3A1e9WL
 +MdO73dnhNGhJNEvCkFcbF5Y7nhdG/MtU5gQQdg==
X-Gm-Gg: ASbGncuGQMRJ8+TzfQOlJcWGEBoFmJFKsi/gGeNdtQB6yXzD0Yzr7lSgwtozknkl6m5
 J23MsxM5XLq09yA92cLmMQm1G20exa+ZOgkoVZJITlh/SGrWqLj5BTB3sUnhPS2Eog7ilW8VroK
 3hGJkZSpbnZcbrA636UBMB8ghHO5sstsE=
X-Google-Smtp-Source: AGHT+IFBmpNLFetMNm8TVVcRaNM512n795DUEI9NHqsfUj4r/t5EJn59gbkOMWaESRsf381t4aTtJdEKedF5FVLlGDc=
X-Received: by 2002:a05:6902:1388:b0:e38:d040:eeed with SMTP id
 3f1490d57ef6-e5d9f78c0c1mr516424276.15.1739305618777; Tue, 11 Feb 2025
 12:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-7-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-7-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 15:26:47 -0500
X-Gm-Features: AWEUYZlEnIy0KJTlz8vVZkFBFsjDpDgvs0SmaAlYpKHh-Zb-zQ78NEjSaS-toks
Message-ID: <CABD7UXO4nMg0p-Nn6ApS+7ZQE1K8685xoXWX3u50jDk1ti1Xww@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] dts: add global runtime context
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
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

On Mon, Feb 3, 2025 at 10:18=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Add a new context module which holds the runtime context. The new
> context will describe the current scenario and aid underlying classes
> used by the test suites to automatically infer their parameters. This
> futher simplies the test writing process as the test writer won't need
> to be concerned about the nodes, and can directly use the tools, e.g.
> TestPmdShell, as needed which implement context awareness.
>
> Bugzilla ID: 1461
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>

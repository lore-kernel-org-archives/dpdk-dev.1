Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4C6D277C9
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 03:46:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECCA2402D5;
	Sat, 10 Jan 2026 04:46:55 +0100 (CET)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49]) by mails.dpdk.org (Postfix) with ESMTP id 477ED4021F
 for <dev@dpdk.org>; Sat, 10 Jan 2026 04:46:54 +0100 (CET)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-5efa6d5dbf5so293038137.1
 for <dev@dpdk.org>; Fri, 09 Jan 2026 19:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768016813; x=1768621613; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dHgsuCsjJzy4HjEwgD/GtlVoWKH7dHL/7B187sX1Okc=;
 b=WNIW4KRrCNzWawGqnkj2jobLm9eL9Xsbc0OSvqv6vEbMoXLSIaYfqMO+bONRaOgteg
 1IIKE1AQKSx55VIePVSCxkNsJMg6jMLqIFTwZEl01WnjRYapJfLawBe11OdFGQ6srdbL
 BP4hIbdRMtV7PtzoaWqlPbNZsoyxg4Cj8+6pdXG+u/HTi4m0bF7zN31lKv9cen+KTfJE
 1G6LVLoaLd4BGlx7fcuxW4qz6L0nLhXG3Be2+qFF0FNEYG5sjNCXr82uLn/CdXrC0bzN
 d/RGJZ7iuCvw7r62Du7jluYKOfXovKWJ+/gWIoDA98vEbGM0pfVWxnBSGgo81rBgLwRy
 /qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768016813; x=1768621613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHgsuCsjJzy4HjEwgD/GtlVoWKH7dHL/7B187sX1Okc=;
 b=XGxmO+aIVq+C5wBGfNioDgcAKpy1GZg3qzHmT9SgnoEQncb0vpk5dBjc8WMeZ8uDaO
 oCr5hQkzdPnjlkeEUmZj8B7FOokikMB1hRIYb1qi15CQj9fgk2A6veo48zereFQ8IkEi
 PeMLeYN8VUxeM+tLEB22IwwgEayhJc7GyJZSiY5zJcUj1uf8KovuByWYpJFh4MdcT8qC
 hsyTuneE/9D+ZCvSq8BLtcswcPcr/BuGCZwQh/XdUcey6L09Bgg1eAg725aD/B6Ph7QL
 imtVVZFIJ3bk59Koekr45IY2h3YnQ3IqXF9DOflYBU4ydX1VyU5T/L8BaIUbn1gYtLke
 rvwQ==
X-Gm-Message-State: AOJu0Yw2K1Xcq1iL2tKaovURPTM7bvijqxIAGn0y+H/zfd/kueJAqNv5
 9lLA8pbkpyKXu8U+4U+Xmu8ckZab6gPR/K5prwbKdr6v0Oxj8zZ1E7LD2CgTf7Wz2e2XysuVKXm
 T893A2Hjp8ax0rtXzJhtgO0pkJoIIsvg=
X-Gm-Gg: AY/fxX5uOCBswrsA8wuOcJC/J9jscgpkDbGgYKyhoLayZOVX1fhmGv2sBMrZ/2Edrt1
 41lH4FLIDdra+075zxL9+2mYbFJPXgHXwKwy2lHfm48U8GElt7gqHSFS13suyvO3g3qH2ZU/OpK
 udJTQ2PqlaymFCSMDdpUSJ8FKyrrWa3DHQSjjtjVk8+D3E7hHrvnYEmb3/G8NrXdOUiW9d5sgTa
 Ngqv13UfN9uYu+7tjzYz8N2rIpAVggZwH6fIvjpBG8Tsd9crxr/OrRQx8ISCh+0XyXdO380MHjA
 SarweQA+kZ9mK0KpDbdcSxLHNAg=
X-Google-Smtp-Source: AGHT+IFs2ltL5boTDasvbmk7MCQuZ+4AZGyjYSMMMkQjUMiK0dVIWGT939mljJxf8+MtbqaLlVwQJ+zu0OAksVY1Yj8=
X-Received: by 2002:a05:6102:3c8a:b0:5df:8f4:61e6 with SMTP id
 ada2fe7eead31-5ecb69555admr4381841137.32.1768016813497; Fri, 09 Jan 2026
 19:46:53 -0800 (PST)
MIME-Version: 1.0
References: <20260108214713.52987-1-scott.k.mitch1@gmail.com>
 <20260108213916.618cb75a@phoenix.local>
 <CAFn2buA5NzmzA0+t1_5auigvQTyT7Ne6RMVaPVU=sdC03nd2Lg@mail.gmail.com>
In-Reply-To: <CAFn2buA5NzmzA0+t1_5auigvQTyT7Ne6RMVaPVU=sdC03nd2Lg@mail.gmail.com>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Fri, 9 Jan 2026 22:46:42 -0500
X-Gm-Features: AZwV_QhbmbIjkGHv_aB_76fWuklWrF32s_BXh56mLY0eXHJazrFS-7y3penr0zg
Message-ID: <CAFn2buBVLdeJmFyHvtazkHXUv7vTeaK_61nxc6b6PsVGTMajCw@mail.gmail.com>
Subject: Re: [PATCH v9] net: optimize raw checksum computation
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, mb@smartsharesystems.com
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

Cross posting from v11 thread:

https://godbolt.org/z/qr39hf76s
rte_ipv4_phdr_cksum and rte_ipv6_phdr_cksum are both fully unrolled
(-O2 or higher). Vectorization also happens (clang chooses
not to vectorize ipv4). yay compilers :)

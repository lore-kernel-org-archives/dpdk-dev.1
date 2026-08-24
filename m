Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76450C5DF81
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 14:56:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87EA840270;
	Mon, 24 Aug 2026 16:56:47 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id BEE08400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 16:56:46 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-836eac5682bso63998407b3.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 07:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787583406; cv=none;
 d=google.com; s=arc-20260327;
 b=S79ynJ8kN3fgqcTPqpouz2aDDbcBifGoBxNx0FvN/Iwkt7UY519gY+TgoE8kL8lKRA
 a8/pSSJJNUshnJVrbC/L0g4Dxi4R+3G4PuOqUTpzVrea3LFiXO3ruEyCJ8cJCPF9dksx
 ppAWSVMQH9cVnpP/RLBSP+K0JuZXdLUUZ2tUuRmw1SwDw+sHLpHhtKKsVuLziM6gfj8i
 oYFfJI4l3lHqfl4KOJWVVwaohTS56qtqT08fA6H+r7Qdf0jLHYijTI290pIB4fYt944K
 ioOPLyTzC2Y7BNuUGYsXkfNzj2zed7IvcJhu4LAQsmSFMdi3HcHCnntDwLB43RS4+FxQ
 Peww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+WgIoQPWc1xEQRaLYWOqByQCVAcjfRePYdbyLuJex8U=;
 fh=f8r4+ldI3t8Wi4zyjoHk+XOYZfAXSyadSsSUqhKN3AE=;
 b=k6y8uQXNtB6JLhF+s4KI1Cob5QiM5gmjNi9ZP0nrN9IYV1WgB59sVSFeX0e9D6o/VP
 0ACktQd6lHoX488kClhSQhAd/rzSJido4LvGtaDEkFHpBTZVAZtgpieTG4qYgTk/viKC
 56Vvs3sS8pOxZk4xb1wSC1XUjUDY+Udiu8Gn9uf2+eJrYMMrWf85d8wWjl7RrbEwrSBI
 Bw6LBhfcYnf1lSGVZqX0ttKBnMAmtS/mXrvHQ9SzkF87gYXJari1wvNR3uAPANknovJO
 T5CeQbYfpjH4JbTnFgvF3TgGH1ho8MOcmV9KyNneAfLO0Uhz3i/0ee8zG+hIF0FSQhih
 fiWA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787583406; x=1788188206; darn=dpdk.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+WgIoQPWc1xEQRaLYWOqByQCVAcjfRePYdbyLuJex8U=;
 b=Nl6ZyDWZWpkTPpx7D9e+7jpNm2Xi1531yjSyKtuzPghqImJsITgSfaGHoB91K9zyLV
 NjqGNxYYWrFx0xbN5G5JO9LBtGWxw5x4Pb6j4uhK6YaFKzpcYbPV0oWLOCUp5FHwUAS0
 yxTubrftFsfbHU9zE3gD6Yk4XcgDsAW/hWw3PVnWVqZ9otf6Nt44L7XYsUyxbXTFUpB8
 2gEgIE4Bw6TgBlA7mi4RSFLrapxyDNnNXqSbuk0x+S3qDb11IW3JaT5twaadzeTnQ7UX
 0Wq0HhXHTpaFSnCB2c1ub019gwGIQbfh+G9CK66jLVsqQYFoO+2oSqXWhA1Sl0P60Y46
 czVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787583406; x=1788188206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+WgIoQPWc1xEQRaLYWOqByQCVAcjfRePYdbyLuJex8U=;
 b=egm15e5GaliZ4CsqPZXN+k/HQuom852rlhjxvUxbAn4obhZYihocWVR5MisiZaVvuy
 G9S7FpmspXVyWUHaVmLPxHkjgkSQDwLU5bj/Og6hiGaBCvZiAwcBDJf2JnEGAO4qMylb
 4Ll9mg4Q8/drZLv2qO/H6qKHB98snEB0gf+OGIccmdnjg2GOY0k+WuOITDKwrPpaLLU6
 K5ucfBwygCpzNgbB3YygW505Rz7imXZ4OuVd0pZ7qfHlvPLVVtF/SX140yNiDtsWuuJJ
 AoVQQsHEnIVp//D7EJbIt8A1D2CXTTv68XQo+syxyOxj+3BbpVS+gC8nwrb23Af4DazO
 WKtA==
X-Gm-Message-State: AFuF++ltbHzbexBfH0fwm3fSd//i6PO7wSU57DL2ZsBKqiRgwI4iAIRv
 Op67Gsro7e63eccA3qC/DCDXeZqVOzPIK517kBE66dqe8BdSeqHY8Jm9hRBDG2ydB3bn140L1n+
 sI7IrxZ+D0aVpKhcDom9dNWvehkGAuIc=
X-Gm-Gg: AR+sD10YZ91kjQ4wauWzeoZtFZx//rRjPkPy2tTvcW3Aca2ziGBsHyKMEGqNUHd/tiK
 0YO3l4D5c9yUgXBvmQF1XFpwWcumAitjv7YfCUTgND+o0LT0hBSmE8yD8nsgrsWkHUvOnmh/nIn
 gYBSuwyF4b4JqLDVj6cW/3YwjW2GtIOD1b2MuNzc9efpK9+TWToz+REtEXQC2szBANtAkIsnu9A
 iHKCg7AW1pbOPHTj/T0OHsOwtvbqNwJQYSVAcP9bNMd+vXXuU1tuH6av0YRLhiY999fc+0fnaV/
 bV1a2Jt8+Jx4DYGzm68hgLoajYEmmWs2xtzoRQGFepYc2F9kQ9nxHi/dQSBcMFRN3yGU4G4VVEI
 AJyVTZcaGKa5KNqE0WHmO
X-Received: by 2002:a05:690c:e1c6:10b0:826:f78b:8462 with SMTP id
 00721157ae682-847091daa5amr98071567b3.7.1787583405785; Mon, 24 Aug 2026
 07:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260823150127.490511-1-mb@smartsharesystems.com>
In-Reply-To: <20260823150127.490511-1-mb@smartsharesystems.com>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Mon, 24 Aug 2026 20:26:19 +0530
X-Gm-Features: AcwNN1XlKU7lQPHqFSvyY0DQjS9f0CFMsFeJ7jkXVd38q7v7DCSkxHe9MxrtsdI
Message-ID: <CALBAE1Mqo1VB9pOE2Gp4vWkG4=_mdn_X4QRFUvapxKFLX9EHOg@mail.gmail.com>
Subject: Re: [PATCH v17] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>, Saeed Bishara <saeed.bishara.os@gmail.com>,
 Robin Jarry <rjarry@redhat.com>
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

On Sun, Aug 23, 2026 at 8:31=E2=80=AFPM Morten Br=C3=B8rup <mb@smartsharesy=
stems.com> wrote:
>
> Added graph node profiling stats, build time configurable by enabling
> RTE_GRAPH_PROFILE in rte_config.h.
>
> Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> ---
> v17:
> * Snapshot cycles as positive number, and subtract after processing.
>   (Robin Jarry)
> v16:
> * Refactored range bucketing for clarity and performance. (AI)
> v15:
> * Used the term "ranges" instead of "intervals". (AI)
> * Described the last range as "%u+" instead of "[%u;[".
>   Correct would be "[%u;+=E2=88=9E[", but prefer ASCII here.
> v14:
> * Changed some minor details suggested by AI.
> v13:
> * Fixed cache alignment; array should be aligned, not struct.
> * Changed some minor details suggested by AI.
> v12:
> * Multiply printed percent values by 100.0. (AI)
> * Added to release note that this feature is disabled by default. (AI)
> v11:
> * Fixed signedness comparison and copy-paste bug.
> v10:
> * Use intervals instead of point samples. (Robin Jarry)
> * Do not double-indent printf continuations.
>   Follows existing coding style in the file, and
>   avoids a long line warning from checkpatch.
> * Rebased.
>   Moved release note to 26.11 file.
> v9:
> * Fixed comment still mentioning 32 objects.
> * Moved sample size array outside loop. (AI)
> * Added release note. (AI)
> v8:
> * Added static const array as local variable, instead of indexing directl=
y
>   into const array. (AI)
>   This also eliminates the space required between "} [idx];" weirdness.
> * Added build time configurable RTE_GRAPH_PROFILE_BURST_SIZE to replace
>   the hardcoded burst size of 32. (AI)
> v7:
> * Use RTE_DIM() in histogram for loop.
> * Added static_assert for histogram index values.
> * Minor details to please checkpatch.
>   Although I disagree with requiring a space when indexing into
>   a constant array "(const type []){values} [idx];",
>   I have changed the code to comply.
> v6:
> * Consolidate the four histogram entries into one array. (Saeed Bishara)
> * Sample at 32 objs instead of a half burst. (Saeed Bishara)
> * Moved stats to different location in rte_node structure. (Jerin)
> * Minor details to please checkpatch.
> v5:
> * Added stats for a half burst and a full burst.
> v4:
> * Added documentation. (AI)
> * Added more comments. (AI)
> * Improved dump. (AI)
> * Debug shows both cycles/call and cycles/obj.
> v3:
> * Debug shows cycles/obj instead of cycles/call.
> * Fixed missing --in-reply-to.
> v2:
> * Fixed indentation.
> ---
>  config/rte_config.h                    |  4 ++
>  doc/guides/prog_guide/graph_lib.rst    |  5 ++
>  doc/guides/rel_notes/release_26_11.rst |  9 ++++
>  lib/graph/graph_debug.c                | 67 ++++++++++++++++++++++++++
>  lib/graph/node.c                       |  2 +
>  lib/graph/rte_graph_worker_common.h    | 57 ++++++++++++++++++++--


Acked-by: Jerin Jacob <jerinj@marvell.com>

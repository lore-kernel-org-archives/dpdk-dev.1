Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAD7CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33C1F40281;
	Fri,  2 Oct 2026 11:46:27 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id D20B54003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:46:25 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3907F7A00CF
 for <dev@dpdk.org>; Fri,  2 Oct 2026 05:46:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Fri, 02 Oct 2026 05:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1790934384;
 x=1791020784; bh=ayigROANkkLWrLVb4DiXRwUGy9FsDdfNosK+9dqQDIs=; b=
 B7YDqr1SpodRkbuMZyBef61NjmLa4T9jkqijAgwMgWnWRAIqquiIo62Ftg0/nzVD
 yB1Z7LUUFTsBkAOansX3ENIemeze89HywwYGsRzU8HitjYffhBZ1FvermB/IipVZ
 Y/KCgjUkdlOkfTu5UrBgLX2xdc2tsGXLXQLwdRHIFhSk/r/qtjYUDSnRXSi6bG4I
 Z6W7GbldCKt2UHGz3Cr+17fl42Xjst+XMYXQjH5gdZuUYD2vPkO7BNIPJki7N2SF
 qQqlccJwRqeje2txSXpOVanqprghd9Mws78iy7d3RrEGhHKJh63tDlhla9CsN2yY
 5J3zfXt8P1wzSNA2RfCGhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790934384; x=
 1791020784; bh=ayigROANkkLWrLVb4DiXRwUGy9FsDdfNosK+9dqQDIs=; b=w
 +pK4B1jcVuybKx2dmKx8MalM9pHQ02ckOf1Igz36D5Q2gYeX7OCqiqWEpiP5QkPT
 Q63OIFw7l9+mVBQlvZVVN1LLCZ4gDGals7Xchxrjv+gD/8tHLH79w20UrDXja8n6
 cuAQCShMrITg8+lv6q2Jjm8gsI60tXpCzzZOtsjZVy1ouUWQ0q8dfM350segQENK
 G5aljOQKLQ6ThNr0FGgp96AHl6e8muWWnbHHZjR1jLaWu+ivFjJzA+W73xlM0msL
 cs/x2VmhS3yoshC5DwCLkdy3rPmZeMT0CLfowPjJDsH4dehEkg7IX65NY+L0gPS1
 PGte4uw7rHKQbg2FR/h7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790934384; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm1:rsa-sha256:FUYiLy+86ejcEZ2KQg0GrSdCbf6TezaLFPuR/jw0EINOMCf
 weDxyfEOTW5zpimBQY/A0pBrZmkZjJRhQDQwKqh2ax4tpbK6g4Fa6il+S+uaPPn2
 UZ3gGC9IPF0lO0q1ui+N8bFqV3fCIahhFd5ijrvnLYCucFW3dlydNMembJKcLWDl
 fCodBahFVZMbi9PjHqakUfwtfkgPDghWOLV+GPHhnbIiWi5gMDVNAn+k9Jl44utP
 0p8e/VSBrP4LjXpLGs5yTthoyTZwwPYJhghzpF0CN8GKVYe7tHk4ETPqhyXaUxq4
 XI85ALAAWZIHTEHJuqXLmd6g8vitdM9e8Y/pzEQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:nbG+bLlv2Myj2Y7jMyH3pD6EPa3XqiVivGPOBb17UVk=:ohnZShox9VWAvJEb472g7a8f0kw6uEUeG8jLHnFN26s=;
X-ME-Sender: <xms:cH2_ajRsInqW5-UzGrZfi50T317Y96BALBatZOLeXatGXu8sZk2Jkw>
 <xme:cH2_agMYZRTBqgaSyg20OLw_ZWtyoUryXpbSB1KkWbQKOGZmnWbdR82Px17ZR88cH
 jYpoAhVGO8QKMP0KIHG61lS_WCAby7B6pEqYVh49-yPj8NM3maDxg>
X-ME-Received: <xmr:cH2_asX-TMdkJEB8VXNTN_6mwYp1lT4rDfVP54mxOwhVuojXY5kZuaf4gVoGjO__mga2hx6KsYvL_xngXKTW>
X-ME-Proxy-Cause: dmFkZTE+1vUbKj7z200CjPWMyTQre/CitAYwtzP9VjIVXwjZj3s2DF7VeYiVaifgIazCwy
 +iIDELaw4kMZ1HuPUC0Z47ESBNbhzglBsSAXE4XAkET3gmwhrtHDX6EO/r5pq54Y5eWzqA
 rueWynV0iy1NytJFovPTEGwQoK1C8psu4TudbL0kdJugpA7a75eUSw0jHEmebw6Bcg9QVr
 S8yiMt2MzAt9P1r+hrAmG0fPZNaJkOZ7IuxsVa3tXq53L61aIMIduHt4AXixMaSVMCCawE
 7yVZDNMMWE0BgJQsaEFF8f4NecFAn/5EVwnsXqePq/s56gdvGJSDHpgObtDJs4KAE3ZeYu
 YmpGqZKT+9CHG8xxZOwflriTBAooFEgFeKJ2ji0wkxn0mSKDPUba/JhGMNXXJkrmdqyiyc
 gFOcHFrUHvhdcasKLFO3iOLqjZ3VYY1owlvYd5iwAavG9FDtL8Ai3CEGUKpj3k5aoaWLeW
 EK4P/plV2ci+jyVzJsvZo+Yq3n33OdTzzl6COcEUxp4VfpX85812BxM5UHlHlIUVUKYo4p
 EyLD3p1T3uSWNoxgBd3Dc8122eumOuVz9O4+jvDJ5v4RNOOzP0S5mPskTEuX+L1A03WMW0
 jxcEXZeZfLBwl81msnAYecTvfEFw6feSRmOhc5PRdO0eSQ19PneWYO7qLaPA
X-ME-Proxy: <xmx:cH2_andedtcQoGZPqy_dkcbjvcSDjjiVJwNr_Ebw_3y4bep6enIAlA>
 <xmx:cH2_aou1CwFi-Fk4rCjrb9l-5fgwuxuJ4N1Ct4X8ZVvQwFv-9vdAYw>
 <xmx:cH2_am9Y3GJmJ8KIjDcEWTMHH3bR4RvzgwjpPX94P7rQw6BmZbieaQ>
 <xmx:cH2_aj0erwzzTbJrJJncK6VChnNZZFK_S9TkGMIZMPYdfUH8vGxKJQ>
 <xmx:cH2_auBSFaCxruEVIxnzQg23bY7-tru3yUk5Vze_XlWpmEhA7zWJBA9L>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 05:46:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, eperezma@redhat.com, maxime.coquelin@redhat.com,
 stephen@networkplumber.org
Subject: Re: [PATCH v2] uapi: update headers to v6.19
Date: Fri, 02 Oct 2026 11:46:21 +0200
Message-ID: <42IOfTxsQM-Md_-aO3EZGA@monjalon.net>
In-Reply-To: <20261001090558.1131763-1-david.marchand@redhat.com>
References: <20260930095800.551314-1-maxime.coquelin@redhat.com>
 <20261001090558.1131763-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

01/10/2026 11:05, David Marchand:
> --- a/devtools/linux-uapi.sh
> +++ b/devtools/linux-uapi.sh
> @@ -13,6 +13,9 @@ file=""
>  check_headers=false
>  quiet=false
>  
> +# Require unifdef
> +unifdef -h >/dev/null 2>&1 || { echo "This script requires unifdef."; exit 1; }

Do you need to send the message to stderr?


> --- a/drivers/net/nbl/nbl_common/nbl_userdev.c
> +++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
> @@ -2,8 +2,9 @@
>   * Copyright 2025 Nebulamatrix Technology Co., Ltd.
>   */
>  
> -#include "nbl_userdev.h"
>  #include <uapi/linux/vfio.h>
> +
> +#include "nbl_userdev.h"
>  #include <rte_vfio.h>

This is tricky.
Is it documented that uAPI headers should be included first?



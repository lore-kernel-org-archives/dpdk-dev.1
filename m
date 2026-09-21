Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D738CC982ED
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:55:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7490E42D92;
	Mon, 21 Sep 2026 17:54:58 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id A6B9542D66
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:54:57 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so1343385a91.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006097;
 x=1790610897; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HR53cLLpDrgrhXx5tbbTvJKcdQRzKLzY8RQXG2nsZEE=;
 b=0dvOqPWXqSGIvS45Xirqz0/MGCbFDsMcEsC7tdkBfQGoDOieTD+9XG7FMgR+PPiDwg
 /JiGEMpr7YbhkwhsoRnG5jubS3vLDE/K6N9sg3485qUTWBCPAZiLS+EWwaQuoA2r8/RU
 Vo9097U6gEul55KkxZ9vuNvlC/Wy/x1q1ADha45ZhBGEX72WK+usFLW1rz7yve79YbHy
 F35R5Ok6FMxwKtIUX+aTc+qWrepk2tDiTaeMKVKleOpu53q2ufLs6vlJKtEbhN/d0d/y
 DD8CywkNe9Z80R/ZTYcCBla8pAt7IBsNZfH4Hxe07PUOKItnkUrtHuI8MoxF4COge9KX
 1z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006097; x=1790610897;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HR53cLLpDrgrhXx5tbbTvJKcdQRzKLzY8RQXG2nsZEE=;
 b=iASZoJV/7zrHvdwbYxGUO/7q74yhpZ1fqMLTntIO/eldctY7xBqD8n0k2p4SN3kH81
 FM42QBV26ByL66z07rUO5J0ke9LDNNOL73JiMLwYcOuf/FAGG+3Jn0no8PLmOUwYWA3E
 6PPRNmLH2aDAGnUItvaWfGik6SsC5SLZFAup3ik0wXH6QXewLQpt2baCsTTSHXstZOV+
 I2W4VW9dOlsusBCsKzySVjLN478Dc6eKIe8FgkaVS/XCVyIf5WofMBRuf50mb3gPYKto
 AiskNZddiVL7sY2BlNmR+nVeHheT8j3g081tfUNBDdz30bUtD3VnSWPFyJxkGYhU5n/i
 F++Q==
X-Gm-Message-State: AFuF++mujAELGxSPx3pJrNTXRjvrGxQPxY8vjxgUCgpAkJzDOP3nktZt
 wety8vARq50m17cnG2WkoxDL/UkF+vDR6dQswlZJWZeVIysi5zvLPor6RsyK0K4y3vFG0WbM3Pc
 TIwsI
X-Gm-Gg: AYBFou2kImLd1kxNujwgmpWuZ7kCB7q4ScDPrq5Lcu16q8rADt41rUgGFsjp/5nsJxO
 m95WA+8a39s1tJI54XwzmlnerkeKP+oMt1maDKj9YWm6crycGxchFzmRroNBVASPJySuK77ZC3U
 LfmVJDeqejv/youBgcT+CZPxswm0xgeXH0salEDuUEE+3f8K3gWAesDE4zfAzxwqLK4jxVEtsQx
 lkUowZ3rsA7dtDuDFbthA9sG7uSesQUCLVENkmbGghsqjqnS4UQUNyaqPuyecF9VmBjlkpPKWve
 AnCdpJ/Ls8xhw/CXQUkjKa+wXrzzKSQ7Jf5HUYBWruQ1fEOQ778Mh9Tp31fpVOUzyaVmvy6/dSj
 JMMnWAN0oRhmn6fO0WASPFBBsjZYNbU/dZ57WD9D/cd6sbdZGI4GJWILdVvzrOv9Fl4IxWRfee8
 nl4w3taeZgaL8gNmpw5pgbbsgIl6MObRisAUT7dTN7ZcZVr0COrx0N6joEluToy6FIgTY0kjfKr
 fWcKv+97usbgFdt496A7l5DY0ObNIArJoD00V2l
X-Received: by 2002:a17:90b:268c:b0:39e:6a7f:6189 with SMTP id
 98e67ed59e1d1-3a066b0f377mr40372a91.26.1790006096677; 
 Mon, 21 Sep 2026 08:54:56 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:54:56 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:46:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Dakota Sicher
 <dakota.sicher@broadcom.com>
Subject: Re: [PATCH v2] net/bnxt: remove duplicate branches and conditions
Message-ID: <20260921084640.44fb7603@phoenix.local>
In-Reply-To: <20260921021711.1033759-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032645.763349-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921021711.1033759-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 20 Sep 2026 20:17:11 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Dakota Sicher <dakota.sicher@broadcom.com>
> 
> Removed ternary operators with identical results and consolidated
> identical branches in bnxt_validate_and_parse_flow_type() and
> bnxt_start_xmit(). The NTUPLE and EM_FLOW variants of several HWRM
> enable-bit and IP address type macros resolve to identical values,
> making the use_ntuple-conditioned ternaries redundant; several
> adjacent if/else-if branches in the Tx checksum-flag dispatch were
> also textually identical (same action for a checksum-combination
> flag and each of its constituent single-flag variants) and have
> been merged.
> 
> Signed-off-by: Dakota Sicher <dakota.sicher@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

Better AI review flagged minor nit:


[PATCH v2] net/bnxt: remove duplicate branches and conditions

Info: the re-indent of the PKT_TX_OIP_IIP_CKSUM,
RTE_MBUF_F_TX_IP_CKSUM, OUTER_IP_CKSUM and IEEE1588 continuation
lines misaligns them. Drop the whitespace churn.


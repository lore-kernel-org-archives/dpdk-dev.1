Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B0606A31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=iii+IK2l;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=y7YLKH0m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5ED240264;
	Thu, 22 Oct 2026 11:39:40 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 2AE8B4003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:39:39 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 873747A013E
 for <dev@dpdk.org>; Thu, 22 Oct 2026 05:39:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Thu, 22 Oct 2026 05:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792661978;
 x=1792748378; bh=+sn7eDYhpBHSUIASdeXWhyGtsRR7nrJlowPb/1YzOng=; b=
 iii+IK2lZDrwundGXtH6G4/Xa2qzEuQcjCd+uk8fAEeFPX0keGrZZzsY2lbOCxGc
 uDShxrKEaSxS9qTsKek61vPAh4DLBzDghhAKNs0AQQUEOlGVFwng+IRvvtXKkKXa
 Kc+6WVGF26ApHNnAicpX8W+SQ1w+Tb/aESVbgkY7Y4nyQvj6FXxZ6ijSg9TP1qSE
 mpj56B4oclWp0jN40m/f5iLGROSvGoWoXGxozKzu8LcCjf0ydPRCzlq2xV64rDK6
 uu6lQpcMKlwa6jbgrdfQGAqAUux9qSeO9e5C+JmBm1xNoDon0ufi/aiRaasAU0Dv
 TJO5lB81TaT0WQXARWZu7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792661978; x=
 1792748378; bh=+sn7eDYhpBHSUIASdeXWhyGtsRR7nrJlowPb/1YzOng=; b=y
 7YLKH0mDWu31vbQBpgUuDdDiqghu/itaW7epoKqQwbYtUBzhhaGMR7Rg7ayoOg+2
 K3D3yjCOm7ui14qFa2s0moiLsKHprF/9uziiDYLNIx4ycY6DXrLHYLnss3QxucrT
 LoLfgmjwNT8blAydhGyN0Tdkby8lSiGWb5mQp91YcEB+m0TPdxNzcdGa0AfOdrfP
 aCCCaLkSKaPecSgNi63tovHw8JYP0//Y4VYlFBJAe4albmdLVgb1BUFlItV9yfD4
 MUX/Vco8su4V1i1TK5WYR8gWC+O99rw8kCThC3BwLWWzRT9IHdyWmxtvnM8p10KL
 DBkF9vC/oX4mu9KXB7qwA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792661978; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:XDvN4mzaT/1QxaY2Wasy2PFNKRLkx77dIrZiIC7p4r+7kiZ
 JZfE1ewbKDp8bvx0yX85jl6FZZd6/QGUHfdCzzI6GJagfdHhtatG7pNsc6BFPu6M
 vTRpOab+iyuqm0humdyYhZ4/CiMXIQ9hj9gYTh74GMNWlushZCw8urT/qGD2xocz
 38lvIvHF7jZeN+acL3miufydoyuQlXmMncYeZeNu4lSBNSlaw2FIHhJR1C0MqUnR
 6cUbQboplZz1Cc0ZD2cG5nSROETADACdaqxI+bOGZsQsyC4YiPwiY7xv2Sc42azV
 ZLhWEz3V9gnBezqyL54kVWKnDz7QKS/W1n/FLXQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:xA7TwfRZd8N+41P+VxszRoB8Wu4VOUzlZt3ws3hthZQ=:CYgxZK8co7PK28ZxWW+pmzwzEmsJvHEQ2q/564nrF3o=;
X-ME-Sender: <xms:2tnZagdSoxFR8xb6iyqFjgbZ76yeoUlTLRFpzzWWc3r_VleZYVCjSQ>
 <xme:2tnZamgiSIwd9XtvqQ05HI7hLtQTWqcxNLA-yC5BrWD-Mj5Yei6CbbKNJlOA4I7hG
 eOw34busAFgIU8STWmvHGgwBZXZDYnktkZz0S5qm24aCeBAa67UxHU>
X-ME-Received: <xmr:2tnZagrJFE0T3Rd2azxHeHvua4rWh2H8R-rN50gQ2z4pEZHbsgFUdlWcn1xYfj3hDWpNJNNbscNyViVUzpSHRig>
X-ME-Proxy-Cause: dmFkZTE1zuQOkUF9n6ri2UjjufdBbGE/0yvX99w/jxSEKU6B9FO9KyA5348RY2pQEd8qV7
 WL9bXwLll18rrOW6vq/nnE3Y2F4vnfVmMa/DnJIFe+qSCaevbxGeuPJsTpkPzkMfPPEshf
 +hrX4W8kZRAxRWjxD1cazEAf6gY/odLW5LUa733qx/ULKBjBsOCRFwFwKHRkWvZuWR6Pd+
 BuzUAIJECpt9FPUDtz3YKPh5BBXJ3IP+oe4lSZTl5zptRrshJ4CAqmor6tb9Ob3lQaH/kz
 E5OyWsZFCSOUWTLQ0OFP63UmSI92LtCcFrC1xdiHUBl9eWAh6tTMo3P32gpJQm0E5f1wsS
 n25CClazd19F+842KKDPpQQvgAVHM1H41Awns+aV9ATzeWbWrQH9lN4fy9cHbNPx3yqAVw
 tH5DQOxTBnf2s8YgRIM4DZ/e4LQBdxFtUV6kz192yawQ+obvr2+Mbhj8BS4AjubCN3qXLA
 hR3e+mvKz6QSt4Pl+UGtncd77x4kC6n0kYthTJIo1PpCYojiPg6UzJtn5EZ8+Hy++j/8T1
 2CiI7tXOPEVl/ffkhlF91ZPEYDq5jm7wDGu1w1fqgArN5LZI0e6vqL/XtvR05KbPy4HhLN
 aOUipqIpk3AoZC3I8WESxtTASXBaehbm3oDZzfpEVwXGjdEAnBJ0UG0SKrFw
X-ME-Proxy: <xmx:2tnZauGMgjG1ZIqdokdthPC4y2RTU7Ysab-YNfNGeZrA0th5ilWajA>
 <xmx:2tnZaikqEpFps341qFRO5QC64eW9W6DwvtRtl5axnfV2MCxd0rOUnA>
 <xmx:2tnZahlNM2t3E3eoinsMEnP_NEKdvswMA3tDlTKuDx8GZ21yt4NAoA>
 <xmx:2tnZajvFiefzyR5nh8mwDKoEqT5RGRhK3W7ZgcPIegZ2QoDvrr8QSQ>
 <xmx:2tnZajiLsChlTwgDCxMMNDZSoJBV5x_Bd-mXT8q2nBSf5EQDmzwY9kEP>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 05:39:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v2 03/12] devtools: handle multiple drivers in doc check
Date: Thu, 22 Oct 2026 11:39:35 +0200
Message-ID: <wiJq03LXT_eqSaTCySngfg@monjalon.net>
In-Reply-To: <20261021103027.2050351-4-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-4-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

21/10/2026 12:30, David Marchand:
> -       report=$($selfdir/parse-flow-support.sh $code $doc)
> +       code_support=$($selfdir/parse-flow-support.sh $code)
> +       report=$(
> +               for category in item action; do
> +                       section="rte_flow ${category}s]"
> +                       code_items=$(echo "$code_support" | sed -n "/$section/,/]/p" |
> +                               sed '/]/d' | sed 's, *=.*,,' | sed '/^$/d' | sort -u)
> +                       doc_items=$(sed -n "/$section/,/]/p" "$doc" |
> +                               sed '/]/d' | sed 's, *=.*,,' | sed '/^$/d' | sort -u)
> +                       if [ -n "$doc_items" ] || [ -n "$code_items" ]; then
> +                               flow_item_diff $1 $code "$doc_items" "$code_items"
> +                       fi |
> +                       grep . |
> +                       sed "s,^,$category ,"
> +               done

This part deserves some comments to understand what we are parsing and why.




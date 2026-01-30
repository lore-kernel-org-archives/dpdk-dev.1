Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F2EE6BF06
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 12:13:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1624B402BD;
	Fri, 30 Jan 2026 13:13:32 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id E394440274
 for <dev@dpdk.org>; Fri, 30 Jan 2026 13:13:30 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so297994166b.2
 for <dev@dpdk.org>; Fri, 30 Jan 2026 04:13:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769775210; cv=none;
 d=google.com; s=arc-20240605;
 b=GN6OUln6IxLAQNG1Sxc5m/QMOyEWIb3+mjt1s8mcASKl1CgcoLPct3stVG0RAI0pmH
 bnV932htG0nQ4R/yDNyeidpXvJLJmHbPUh6sPhpwSeJrjHVx/gxQt48ZlNQpRMRS0PXf
 biFO9aAshWdgHv2xvxMhPU9GJIzP/cSrCOhzBX6nos3YaHvYMkoWUEBs8IiEzZf8+1bQ
 Y0kWBuKDZUJ52B0Fvs4yCFrSNxieZfrr4S/ot1ORzsvV+HCrPjldKmelhCD/YDLybNw9
 JjwgAfvNBMWyah6hrhIT+MfdCu+Pb4nNoBzY0KMX+/fNCKAsCZ6iIURnE4eKCepQN+a8
 BjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uwYZHTlgz7JvIO+/liLFMhsU6c6atnR3IApM88O1bHk=;
 fh=t33Egyn4DAOwVRnwraldPtDjoBFAjogf3LzpsEMwxHQ=;
 b=bs567c0fVXTgaAayupU2UgFE3ZQlmNCcmH7PwqGUnYSbfQZrg2JV5QaTf3sKNgF1wF
 chCyP6WffMRFh0YqJ8nnik4udhmxr2tWfYx6y1s9MQAgTAPXTYm7QsNXg5vlWcduceRP
 XqPR5cXKlI4HYa+6c7wcZH6uhpg1fS0BO2yVIfs9afa8QQepUnPD2bJAk7t2CRCxyCGt
 7Q0U6HmuLESxWvwGBk/+s5h7ePlsINbzmBzn3pdsXu7qvhcrxJl16Rn9D9HBtqtRjXk8
 jb6NkLoG5Wk0QS4Vk1MQQOJGX7M262MuIghuK9LzXoklVBW68CONjZwCotZB2yLtDE90
 GhoA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769775210; x=1770380010; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uwYZHTlgz7JvIO+/liLFMhsU6c6atnR3IApM88O1bHk=;
 b=rSjuK/VspKMIoAcQt5frGs+ZADDAmkzZeW0NVuNQEXmg7lwdMl2e8Cr/R1ihchnX8S
 6p0AGb/3+sACi1roKaZiu8fW8cBzRbAcXIQt5HApdWfV95bFrIAPX/JxqmQeeyWGhOqZ
 OjSC4k3Jqd1r1OLX95M3sF42rGPAz79dMBgIQPCHKqIcRe4H8UG6SOUqsRfxVY+J5mEV
 NMAMpT/StamtEo8y9UYBptkiXC0P00SkzAsBoPBeK30//s8b2YwTr9jtDSGLy337ZDzw
 BbdBaGxAfaiCl+N/W0rxBwbIFz09YSU0wduxY01zYN6vQvMETAXT6mTBAmpT3mMS6dWq
 mhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769775210; x=1770380010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwYZHTlgz7JvIO+/liLFMhsU6c6atnR3IApM88O1bHk=;
 b=wLFsyHeq01Ji+z6gv++FWRveIe4MzuSd478hOaAcfVnkIb9GxvdEyUPPxxbSACG80D
 5EBaVV6SDhD9XeWV60740SYOCPQhRhK5wTUGQZ6c3QdEodLjwVCkI4vCySnUvGC4DMD0
 fE7oOy9hld0kbP6sG33kuH8nMa8NS4wqik5GqK2WCcnsmGyAHxuXDYXNpULha3KIkUVq
 kpcz7Oc2Hm9Fpx/cU/+kVvUjKxo+8zC5iBG8Mr8ySXn/JirGLhE3YOtei/+dGkbjaNhm
 e6n7ElJgvwoKwsbFG1ljK92byN1ClZToG92P9kTeCbLhd/PGTaF4DJzeF7ScEfp4jX58
 hYQg==
X-Gm-Message-State: AOJu0YzpDfnRAdCueAwj2CaOljisjXBuE9rF9ieXNsKqVUjIUjF3318X
 G/YJBDt5cYz+ukoaEeLfbzeLmSXTB9TPwnpmXF3z6YKOMHYB8bmBNBEuAc+vQuS/O5x9n3UtUO0
 ZzvVMCmEJ08iyir6EjDS8I8PJlmBx8uxn/AuxGF/fggsSUNCNZQ/Sdog=
X-Gm-Gg: AZuq6aL9Z7992oh8CdB5FsTipI0Nb+DqdKpCS9Bq/otlAorZBOgK0mHsDtqyfZnJaNs
 SbstU5+Fk4InhMrp1xoiD/hVTJ1efhYgsX3P1ivimgHZPz4BO9W1YT/vo6/Q+rWjzm96hgL6ALr
 iVt6MjOm05eDqX6ZBpoEFXwCfpD+PYcbFW+LZiBtkvLiMMBWmZOc2vtYV6STUM6U2EWXekrN+PE
 AafVao30UjKbR10wKVAh1YS75HfUy0Wy9khIadfJoV3FhCbcg11dvyODNPybt6oajWeKcA=
X-Received: by 2002:a17:907:9284:b0:b87:d44:81d with SMTP id
 a640c23a62f3a-b8dff754e5dmr144745666b.45.1769775210354; Fri, 30 Jan 2026
 04:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20260129114202.61185-1-sismis@dyna-nic.com>
 <20260129114202.61185-4-sismis@dyna-nic.com>
 <20260129092815.750af8c6@phoenix.local>
In-Reply-To: <20260129092815.750af8c6@phoenix.local>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Fri, 30 Jan 2026 13:13:18 +0100
X-Gm-Features: AZwV_QjqDlfuVua831qEXnqmBZwVOAuyfSoxmVYCe_DmR3_GNxjDnrlSLaFzE3o
Message-ID: <CAPQRu6HhHgu5nxSHJgPud40-UThys2UNiFtPZQq7wpReRDORgw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] flow_parser: add shared parser library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000bee62c064999e615"
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

--000000000000bee62c064999e615
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 29. 1. 2026 v 18:28 odes=C3=ADlatel Stephen Hemminger <
stephen@networkplumber.org> napsal:

>
> How big is this beast?
>

Heh, I am not sure if this was rhetorical or an actual technical question,
but to answer, pahole reports it as 26,400 bytes big.
Previously, it was sized similarly (25,884 B), it was just spread out over
many globally defined arrays.
The ~500 byte increase comes from new *_cache arrays (raw_encap_conf_cache,
raw_decap_conf_cache, etc.).
In the original testpmd, external code accessed global arrays directly
(e.g., raw_encap_confs[idx].data). The library provides accessor APIs like
rte_flow_parser_raw_encap_conf_get() that return const struct
rte_flow_action_raw_encap *. Since this API returns a pointer to a
properly-typed action struct (not just raw data), the library needs storage
for these structs.

--000000000000bee62c064999e615
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=C4=8Dt 29. 1. =
2026 v=C2=A018:28 odes=C3=ADlatel Stephen Hemminger &lt;<a href=3D"mailto:s=
tephen@networkplumber.org">stephen@networkplumber.org</a>&gt; napsal:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
How big is this beast?<br></blockquote><div><br></div><div>Heh, I am not su=
re if this was rhetorical or an actual technical question, but to answer, p=
ahole reports it as 26,400 bytes big.</div><div>Previously, it was sized si=
milarly (25,884 B), it was just spread out over many globally defined array=
s.</div><div>The ~500 byte increase comes from new *_cache arrays (raw_enca=
p_conf_cache, raw_decap_conf_cache, etc.).<br>In the original testpmd, exte=
rnal code accessed global arrays directly (e.g., raw_encap_confs[idx].data)=
. The library provides accessor APIs like rte_flow_parser_raw_encap_conf_ge=
t() that return const struct rte_flow_action_raw_encap *. Since this API re=
turns a pointer to a properly-typed action struct (not just raw data), the =
library needs storage for these structs.</div></div></div>

--000000000000bee62c064999e615--

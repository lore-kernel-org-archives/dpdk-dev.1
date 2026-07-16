Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA0C44501
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Jul 2026 08:00:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C66040270;
	Thu, 16 Jul 2026 10:00:49 +0200 (CEST)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by mails.dpdk.org (Postfix) with ESMTP id C5938400D5
 for <dev@dpdk.org>; Thu, 16 Jul 2026 10:00:47 +0200 (CEST)
Received: by mail-qk1-f170.google.com with SMTP id
 af79cd13be357-92e85499ffbso235770885a.0
 for <dev@dpdk.org>; Thu, 16 Jul 2026 01:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784188847; cv=none;
 d=google.com; s=arc-20260327;
 b=Y5XBWxMYAlC/ndT5tblaGQ072bQD74AyapG+O/+cVDtB97RGyUXcsIF0nRkReKIu/E
 2ZC4vxKowXUKq7kzybpYT9qE0d8HJN0nO3qjtm01y8AAunAtwa9cm7w3yU7arieQ/N5M
 5BC8Ejkc3h8zadjpp9eSwkbeL+zCZMxoZ8El4VbI+bf9cLRpOap+sdUrQKMPZM6IBhIi
 Wu/CUAFCJsH47R2VtRv3smhVbLwONVKxVLY0S1npUBwa7+zLEQWVlKhIk/vhq5ujQAGF
 8HjktOF0skA2LKIO0e4yHEeCUBHA9oTGmko0bYzAn9ZUUxJcTa0q66P23ERZypfyJVRp
 jA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=JWNUXaKlRe7kcNbTgNk3HQL20Skgh4t2Btl2pAy+dvo=;
 fh=4D+H/aZArgO3pKL0hbChWYuK41HLU16sE2PVqXIbSeE=;
 b=gjFTapieGXv4AIBHMIOTQITD8f3S/PXqxn8VTPrA9I1acj/OOWDIHjICcvDLU2MkOX
 Z5opR12Cfd9NPLPEryuZGv7ovubbUWR1/Q2a3htKJO6WFZZ9ziKpTmBR0B8boEbgGeRl
 e3S3ZlIpKC/xu5Ohl3vy4uxkI6wGVAbJrpQ+hB0a8i2YJ8Dz71TmChAlVS6G+S3wwCGR
 tUmvDmuCZzCfFUUuk9RJBmkmOoJRnKcrkmXHVZ3ui2llZeW4MR0U4ZhqxR2RBXM7t1I7
 q4urLjNLGmYA6DbFQIlK2o7gvIK7r9QZgi2MKQoCB0RhOJ4XLfV77GzjsRduoIU4h/SF
 KVag==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784188847; x=1784793647;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JWNUXaKlRe7kcNbTgNk3HQL20Skgh4t2Btl2pAy+dvo=;
 b=dCdVZIWmAAUstC0CM6ndFzxv6IRRlq7WBr4tFClMzzaaSc+f1/y8/4VPHVF1T0aKNy
 KlBvMp6Lb80AKI9PzDZ/jxhnR6Nh6XmjImZjizzegwU0SXe6qk6rxXuvOQ/pLYoPwqzA
 pZEmtGBLkkdVrN4yBa/ijOcZ8FrBAAJD/bMPMJUPMMzi6tJV38q6E6rwd1l2ob+LJJco
 BguWmRbnObB7ujEH0UciJP4iiLnZDsLfenZrJwmU8rY70sLPV38NXOMVHk1+Jd+cNyEd
 WAo2bafuj6lTrsbZ6fVTrP7uNUYY6pfKfQrdmGc4Ztq5KBao8vcKKcsTxPc0U4BBsoqo
 jNRg==
X-Gm-Message-State: AOJu0YwEGhOAtkQtf1JHl6Wfkyeslc6mgfCY4CVLr5CW8awdYACubpe6
 tpQ5IWbM2GATZ5DMaFP7VGTS64GDxTvTYov9Z1/B/XJjj3sWNG1YXfQB4F7j2UPn/yu+kZeA/6d
 mCL7e+xlfOj3ZtQ2JG1Picd7m0k+PUNo=
X-Gm-Gg: AfdE7ckBKruDvBQD5g+IpUJe+BTFPuCBAVdbMWxnBqJV+yI4Q00s46mSKkqbFJhVwq/
 Hf6BLQZQdoBifyf7w90fEbXJaY5mtHfpJUpp7BFvDp3RT64vymYcRzMAKC3Th3X8j7T1oTml2kK
 J2fXgZGJ8n11xDusCvJQZYMxJWoq0OvAGzXBn0rucRJo2dEfQEF8qlTPjvmXuxlBcmGr89eTgwF
 284t7ZKsEjTSR66uepHOt0hRBItMP6zu4GawnxusJHA39+TpY699mIYQ5hljePZB0LH5Jyotf4z
 p44VujLYEtAneqA=
X-Received: by 2002:a05:620a:3190:b0:92e:c118:1899 with SMTP id
 af79cd13be357-92ef2c4e17emr2268994485a.76.1784188846895; Thu, 16 Jul 2026
 01:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260630123857.392884-1-maxime@leroys.fr>
 <CAHHRULVvBsUjxVJh++BKsV_tGJLnh2Fuo+fJYh-=M_rsTKmVtg@mail.gmail.com>
 <8d4177f8-093e-4460-9245-0a1e9e744826@oss.nxp.com>
In-Reply-To: <8d4177f8-093e-4460-9245-0a1e9e744826@oss.nxp.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Thu, 16 Jul 2026 10:00:36 +0200
X-Gm-Features: AUfX_mymSsztP8nbRegurMpDrquZZxIV06SoShBkQOb-a85v82_Om1W96EN6srk
Message-ID: <CAHHRULUgEqtqjMKr-cmFvXZd_jsbihGRK=m_UE+K1HPFYaD-YA@mail.gmail.com>
Subject: Re: [RFC PATCH] net/dpaa2: fix RSS at inner level for non-tunnelled
 traffic
To: Hemant Agrawal <hemant.agrawal@nxp.com>
Cc: dev@dpdk.org, Jun Yang <jun.yang@nxp.com>,
 Gagandeep Singh <g.singh@nxp.com>
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

On Thu, Jul 16, 2026 at 9:48=E2=80=AFAM Hemant Agrawal
<hemant.agrawal@oss.nxp.com> wrote:
>
>
> On 15-07-2026 22:30, Maxime Leroy wrote:
>
> Hi Hemant,
>
> Do you have any preference between the different approaches proposed belo=
w?
>
> Regards,
>
> Maxime Leroy
>
> On Tue, Jun 30, 2026 at 2:39=E2=80=AFPM Maxime Leroy <maxime@leroys.fr> w=
rote:
>
> When RTE_ETH_RSS_LEVEL_INNERMOST is requested, the IP key extracts use
> the innermost header index (HDR_INDEX_LAST). The hardware only resolves
> that index when several IP headers are stacked: for a non-tunnelled
> frame, which carries a single IP header, the extraction returns nothing.
> The RSS hash is then constant and all such frames are steered to a
> single Rx queue.
>
> Always also extract the outer IP (header index 0), which the hardware
> resolves for any frame. Non-tunnelled frames are thus hashed on their
> only IP header, while tunnelled frames keep being hashed on their inner
> IP.
>
> This is a deliberate tradeoff: the ethdev API defines
> RTE_ETH_RSS_LEVEL_INNERMOST as hashing the innermost header only, but the
> hardware cannot do that without breaking RSS for plain traffic. As a
> consequence, two tunnelled flows with the same inner header but
> different outer IPs may hash to different queues. This limitation is
> documented in the dpaa2 guide.
>
> Alternatives considered (feedback welcome, hence RFC):
>
> - Hash both outer and inner only under RTE_ETH_RSS_LEVEL_PMD_DEFAULT and
>   keep INNERMOST strictly inner-only. The ethdev API leaves the default
>   level to the PMD, so this stays API-compliant; it changes the default
>   hash for tunnelled traffic.
>
> - Add a generic RTE_ETH_RSS_LEVEL_OUTER_INNER value to the ethdev API so
>   applications can request hashing on both encapsulation levels
>   explicitly, instead of overloading INNERMOST. This needs an ethdev API
>   change and agreement from other PMDs.
>
> Fixes: 32f701671d2f ("net/dpaa2: support inner RSS level for tunnelled tr=
affic")
> Signed-off-by: Maxime Leroy <maxime@leroys.fr>
>
> Hi Maxime,
>
> My preference is to keep RTE_ETH_RSS_LEVEL_INNERMOST semantics unchanged =
and strictly hash on the innermost header.
>
> I would rather use the PMD-defined default level to provide the best RSS =
distribution for both plain and tunnelled traffic. Overloading INNERMOST to=
 include the outer IP makes the behavior diverge from the ethdev definition=
 and may surprise applications relying on true inner-header affinity.
>
> Longer term, an explicit OUTER_INNER RSS level would be the cleanest solu=
tion if there is interest from other PMDs.
>
> Regards,
>
> Hemant

Thanks for the feedback, but I have a concern with keeping INNERMOST
strictly inner-only on dpaa2.

The ethdev API defines INNERMOST in terms of the innermost
encapsulation level, not the presence of a tunnel. A plain frame has a
single level, so its innermost header is its only IP header, and
INNERMOST must hash it. Collapsing all non-tunnelled traffic onto one
queue is not "strict inner-only", it is broken RSS for the common
case.

dpaa2 cannot express true innermost-only: we map innermost to
HDR_INDEX_LAST, which only resolves when at least two IP headers are
stacked. For a single header nothing resolves, hence the constant hash
today. The only way to hash a plain frame's IP is to also extract
header index 0 (always resolves), which unavoidably folds the outer IP
into the hash for tunnelled frames.

I can move the outer+inner extraction under PMD_DEFAULT as you
suggest. But that leaves only two options for INNERMOST on dpaa2:
 - drop INNERMOST support entirely (reject the level), or
 - keep it strictly inner-only and accept it does not respect the API
for plain traffic (single queue).

Which of the two do you prefer?

Regards,
Maxime

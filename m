Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF5DC43458
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Jul 2026 14:41:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2F44402C5;
	Fri,  3 Jul 2026 16:41:36 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id F028F4026F
 for <dev@dpdk.org>; Fri,  3 Jul 2026 16:41:35 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so4985375ad.1
 for <dev@dpdk.org>; Fri, 03 Jul 2026 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783089695;
 x=1783694495; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1CJu+cC0uRgnN4+Vx8yybKYaJcAB1kyr47ZZBS4bkVI=;
 b=0rRxhEUnGCwOkPBlvo11b0FtbvptP63tc8wNSO+8vri4BAi7SEsQBi8GROVDl+Z9ki
 wigyzmMUR1bjlBYfI+OqN40jjOJHGZPTrcbNrXj/yfGOnIv87czjiLbUeMU7xkYdqHyO
 QS0HJ6dPaX6u89rhR3EsXYpbqdSXxAed5e+SZ38y1qzTfQhnQRnEu5sfKtQrjccnvBJz
 zwBZFhCr2we5YT0parszIZKRDPBY0bMwb21EvJ1b7itztuQdsE9gkkbvZNqWY4TtKHEJ
 8p4O/gFdVDCHmxUIMFLopdLaICHr8Fl+WTfOqoY7/PEP+NcqhORdO39tlxGzzQb0/cNB
 SvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783089695; x=1783694495;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1CJu+cC0uRgnN4+Vx8yybKYaJcAB1kyr47ZZBS4bkVI=;
 b=VqWjJ3g1wErozGRX4YrUXik0SUAtDtdgMLYOHZhAi98RE1K+om89zMquOWmkrWE3IM
 b7p3pP5ctHZ7MFCEgWRf31AU6BbJQ2ssnUeu10Q9Om/bDoHGAq7Gf/zPWpQqliqkDUpx
 7lpa53cYR7dzz/2F+FYSbVgmri2NYk+N2AxdfnRW221JbaRGHBQHVzPpOvAtzENnJvAs
 tX46Ow1vdvCudoAb98YKiI0DC1Tfq5VKrrhaFezYcjlraZb7tS8FOIpVK8LZkht3U4JB
 yQKBGw0ap7Sr1P2sgU1Gwtxt5YTCRZ58G49e1IG/n8c6VQYTUudv/sGK6YMV0mOvYMAx
 PeSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ3iYVJtUZ91kKopZ36r02SdeBSg9M2yZhojx1erWZRNVOOC9+MuNjnMhiFjFY/DF3CJw=@dpdk.org
X-Gm-Message-State: AOJu0YzaWE3dTgNpa4H4Ms1fTR8YGvJdYBdr305FhLNHXRgoOvo6PmRk
 z7cBjyMywAIIDO+bJ/taSnHOglNoLTfaC8uHR8IjBkSldhEvGZj8SsZuBIZkt+W53RE=
X-Gm-Gg: AfdE7cma2ikPl+nhKfAKwkwNemMkc1F86ArbFciGQQ1RVFtumozObMEO0JlFRMkWkaQ
 HxchSIxTXN/iMVyamtrCdZCcOzjYan4hZHnWUTEpELgWtxobWqXL57rzNiPCfDHH6Jzlxw99Iy1
 gPfxCbLgIBj+1OSAJoTCJTXnL7f8W2zEHxxAzoZOJW4DeCUT7zZxK2UVORYKDYJqnMju2qq0qJ+
 m+fRt1nMGoThd8zzDFiEZwmqgoLWA7kcVoRuKqFboB4FLqTEMd8kZJJ9lBT1jID8zMItIFxSBll
 Ar8QRrjd3j6vjhNbihRmP+e/Vtfp/oBYAmzfEN0bPaCnzUs3F93HMJWoXeb71UxL1SjVftKxuH5
 cH7dBQMOe07qQAKq6g1oBHsbSgdSlHHXGLsdlrXRQRBQ9itS4HYBfrAQKHFOCE0l0mccvPVXv/U
 UNUoF3Zyxi7G+nDDiQGRxElgpnWz3Pks1oJlSEroN94pLP6fxjkUFHZA==
X-Received: by 2002:a17:90a:e7cd:b0:37f:464d:ea38 with SMTP id
 98e67ed59e1d1-380ba70e00cmr9805204a91.0.1783089694906; 
 Fri, 03 Jul 2026 07:41:34 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f116065c5sm18974792eec.11.2026.07.03.07.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:41:34 -0700 (PDT)
Date: Fri, 3 Jul 2026 07:41:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Su Sai <spiderdetective.ss@gmail.com>
Cc: marat.khalili@huawei.com, dev@dpdk.org
Subject: Re: [v4] net/cksum: compute raw cksum for several segments
Message-ID: <20260703074132.2a718abe@phoenix.local>
In-Reply-To: <20260618063242.99189-1-spiderdetective.ss@gmail.com>
References: <1f2b21bd87a24610bc09b3b8da8100b5@huawei.com>
 <20260618063242.99189-1-spiderdetective.ss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 18 Jun 2026 14:32:42 +0800
Su Sai <spiderdetective.ss@gmail.com> wrote:

> The rte_raw_cksum_mbuf function is used to compute
> the raw checksum of a packet.
> If the packet payload stored in multi mbuf, the function
> will goto the hard case. In hard case,
> the variable 'tmp' is a type of uint32_t,
> so rte_bswap16 will drop high 16 bit.
> Meanwhile, the variable 'sum' is a type of uint32_t,
> so 'sum +=3D tmp' will drop the carry when overflow.
> Both drop will make cksum incorrect.
> This commit fixes the above bug.
>=20
> Signed-off-by: Su Sai <spiderdetective.ss@gmail.com>
> Acked-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Still one error in the test.

Error =E2=80=94 double-free in test_l4_cksum_multi_mbufs() (app/test/test_c=
ksum.c)
The segments are chained into one packet (rte_pktmbuf_chain sets
m[0]->next =3D m[1], m[1]->next =3D m[2]), but cleanup then calls
rte_pktmbuf_free_bulk(m, segs_len) over the array.
rte_pktmbuf_free_bulk walks the ->next chain of each array element, so
index 0 frees the entire chain (m[0], m[1], m[2]), and indices 1 and 2
then free m[1]/m[2] a second time. This fires on the normal success
path every run, and on the fail path whenever =E2=89=A52 segments were chai=
ned
=E2=80=94 a debug/ASAN build will abort on the sanity check, and a normal b=
uild
corrupts pool accounting. The array-of-independent-mbufs contract that
free_bulk expects doesn't hold here because the elements alias one
chain. Free the chain once through its head:

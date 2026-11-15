Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F0606A329
	for <dpdk-dev@archiver.kernel.org>; Sun, 15 Nov 2026 21:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=XVbVLhQg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADDC940275;
	Sun, 15 Nov 2026 22:48:27 +0100 (CET)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mails.dpdk.org (Postfix) with ESMTPS id 5F24440150
 for <dev@dpdk.org>; Sun, 15 Nov 2026 22:48:26 +0100 (CET)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ae2b7e1e17so2540669a91.3
 for <dev@dpdk.org>; Sun, 15 Nov 2026 13:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794779305;
 x=1795384105; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hU8jFec71SbA4fCEa4Cn2ivfCur+IpXCZ/H1Hq1ekuY=;
 b=XVbVLhQgCfk+Lw7hI66zZPNk0FpBYXtLVvNSj+nyqprFt27r2EtwH59tiQL4bkTRy3
 t7XEU2uKeSOpumc/uv9BrXnaSjEPYIa0FFr6XFNmfQhWSGWkpESL5/l45tnlndTSiNtc
 VTB+f98DezPNrRvmeS/gaCEyMqNGfQsjto7vlwm836Hxi0RApnpkuPZ9BPJMMDcCjaXA
 3zwxnGzy6H54Q0xZL2bdGywvD0L+/kzoUF+t7kXB7Neu5/KDgzbPhQpqnytO39d0SzJ+
 6fxXcpD+tf/T1s2b+WcJEMxkcIYKT8htl9UXw4negOCg/YsdTR+QesoplIx/TaVfa4Oj
 ubbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794779305; x=1795384105;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hU8jFec71SbA4fCEa4Cn2ivfCur+IpXCZ/H1Hq1ekuY=;
 b=z3vKdw6zYlXN0uNmOYTFutPsZVdhuWOU6dV3pyeakuwZSGbjR40gcsa9RRp9aGwhSV
 xyUZWDVBteCnNCjNiHfgKilRVvjnG4dKPRJypWTsUKn0hMR2NW+12+xyKylgvb8X3U/j
 VJxJ9fbsPrgkRYm3TTnTq3C8aN57v9lU11F6ebt0l6m1LA2N23csk0ymObkqWD2uTNgp
 DyQb3jdzdv4sqWZctMLZyjJPLaEFKX2kQNo7JE/uyAzbHQIRWbCg5Vk6PJFQwXYHPoVd
 9dYpx85gV8vmOvYN93/ZTZ5A8sreOekrbAS1XzNYupGtXeIHz6DmMS7o5n13K8EcM/jy
 zFuQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE5ztdCkLb90xwDS4DUYB50FLOjhSTiO8mTJUiROBVZOzntcxF1g0gKVaqM37oVvo66Gu4=@dpdk.org
X-Gm-Message-State: APuU4Z+AACFrM/9eDw9UGxgxeb2zD8PwK6OwKQlktr+Ok96tdEzZfMFh
 eRsATkYcQytMkmicSNI4OndYBHsB8paICe/+8tKxjHgLUB+P4zZ+d/tT9lYWBjSwIlE=
X-Gm-Gg: AYBFou3EgZYciy0ZOQzvDsXbOKA+6c/Au5iiAeE4tBmdF8jBJkniUNJJz/h05mgCUbv
 aexC78/fZ3pnjkPT7Xa9/p//IbL55+7U2NgOHIbMBvpZeYi7U7Cc0sa8NKEtqHifvIv4UhpIh6s
 NWvOOZOUKz6iwTwKopUeIs4xE+H6WyhbwZx13EoUQ9uNSPlqWbVn5snLjPQinUo20xLnqxlQ244
 TREVnt1Iah1TUDROD06mTa7WH8b5ZU5TGIgLMR06933bqAoyXCmsTLp9k5kZD5+flactpMCeEwi
 LPlRHkgewxtY/cLilu3J6uDL2Xd/W3OZgCdNapDL7u6oUUiUMQxnItR69ctzyYBZb3bTpTDE3A6
 xZpxLMy7jPxuT5wnHLV+ulcy1H7Y9/tqaNaqWh65jd680ueDI2DrMGd0a9WpQRcDLrMUu8hFci2
 3rD7H2xn7eTbf8zqWcu9qGdMTQaUnj1u6mLFbSdFXMTSLtcO38sDmdpA6s/9t7PhycEE0425PSN
 ZSC1FG5uhCVTo2us/upE2Zp7URgV79M+6kZzCfDIhYjUTrFR/YsRM+d4HdFRmM0k0UFxdEGmPVt
 iK64lxZ5dvG5uNOJx6PKrLTxDS79uo27i8ttgItB1krVVCF9DBris1kefvFVc8ADYRWhYI56xsl
 1H5S9h80xq7oskhzyazA=
X-Received: by 2002:a17:90b:384f:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-3b1b0b659bfmr7807573a91.18.1794779304637; 
 Sun, 15 Nov 2026 13:48:24 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b245f0c3sm7172134a91.0.2026.11.15.13.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 13:48:24 -0800 (PST)
Date: Sun, 15 Nov 2026 13:48:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bulatov Mark <ms.bulatov7@gmail.com>
Cc: Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= <niklas.soderlund@corigine.com>,
 Chaoyong He <chaoyong.he@corigine.com>, dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH] net/nfp: fix wrong argument order in nfp_encode_basic
Message-ID: <20261115134822.7c82ac95@phoenix.local>
In-Reply-To: <20261113142823.5918-1-ms.bulatov7@gmail.com>
References: <20261113142823.5918-1-ms.bulatov7@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 17:28:23 +0300
Bulatov Mark <ms.bulatov7@gmail.com> wrote:

> The function nfp_encode_basic_qdr() takes cpp_tgt as its second argument
> and dest_island as its third. However, the implementation of this function
> implies the opposite: dest_island should be the second argument, and
> cpp_tgt the third.
>=20
> Furthermore, the implementation compares the second argument against a
> negative value, whereas the cpp_tgt parameter =E2=80=94 as defined in the
> nfp_target.h header file=E2=80=94consists of a set of values =E2=80=8B=E2=
=80=8Bthat does not
> include any negative numbers. The situation is exactly the reverse for
> the nfp_decode_basic() function, which receives a value for which these
> definitions are not entirely appropriate.
>=20
> Fix this by swapping the arguments.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: e6858e7e7c ("net/nfp: move shared target logic to own file")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Mark Bulatov <ms.bulatov7@gmail.com>
> ---

Several issues need fixing from AI review.

[PATCH] net/nfp: fix wrong argument order in nfp_encode_basic

The fix is correct. nfp_encode_basic_qdr() is declared as
(addr, dest_island, cpp_tgt, ...) and all four callers pass
(addr, cpp_tgt, dest_island, ...). With the swap, decode skipped the
MU/CT_XPB guard on the real target and the final compare checked the
decoded island against NFP_CPP_TARGET_QDR (2) instead of dest_island,
so QDR encoding failed with -EINVAL unless the island happened to be 2.

Warning: Author does not match Signed-off-by.

  The patch has no "From: Mark Bulatov" line in the body, so git am
  records the author as "Bulatov Mark" while the Signed-off-by is
  "Mark Bulatov". The first patch has the body From: line; this one
  needs it too, or fix user.name so the header is right.

Warning: Commit message contains non-ASCII characters: two em-dashes
and two zero-width spaces (U+200B) in "values that". The second
paragraph is also hard to follow. Suggest:

	nfp_encode_basic_qdr() takes dest_island as its second argument
	and cpp_tgt as its third, but all callers in nfp_encode_basic()
	pass them in the opposite order. As a result nfp_decode_basic()
	gets the island ID as the target, and the island check compares
	against NFP_CPP_TARGET_QDR instead of the requested island.

	Swap the arguments.

Warning: Fixes tag needs a 12 character hash:

	Fixes: e6858e7e7cd3 ("net/nfp: move shared target logic to own file")

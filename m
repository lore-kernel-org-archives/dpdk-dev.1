Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596BFC4453C
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 14:20:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14C1740270;
	Wed, 22 Jul 2026 16:20:10 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 by mails.dpdk.org (Postfix) with ESMTP id 02FCB4014F
 for <dev@dpdk.org>; Wed, 22 Jul 2026 16:20:08 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 13AB01D00118;
 Wed, 22 Jul 2026 10:20:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 10:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1784730007;
 x=1784816407; bh=yXEjsQgWf9XrVmD/SD1CBvreETdskXLwVHBOnvgV02o=; b=
 C+SVHbWWerpSTecX1gxAlVteyW9cbDDyP8vHfxyWiXkoEgPkX+HI1osUTR0ZoY0u
 bn6FZkhNMvHkuBdz1w8MEAL9Wxk0q++KggmFKNkEAoeUboC5Xgapt/4UBmt4bT9p
 2nFNPSTRfNIYDW50laj7042arLJBTXYzz8pofex4krb0VwGqrPgTRvYrCp4y9oWj
 Yaz2H4yidB5mSaslD8esKFL5d57zcH5D5nidB2fcbsDmfn6binMmiyOn7qnt+ycx
 hQLN5HbcLmsDzyKg5rerB9FlxaBtLkmzviYmlDBBLl+a3kYyuWVCvbwRHk216fmq
 B0VVDYxTpvRNb9+5+CM0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784730007; x=
 1784816407; bh=yXEjsQgWf9XrVmD/SD1CBvreETdskXLwVHBOnvgV02o=; b=h
 0psjnC03hNeRU2HcOqcgMh1f09VkunVxjaF4IyIxXs8tZA8Qq5GeEZ6jEpzzdrvH
 Tou49EcnhqM9uanYqx+TNGlosj6UlbcyqCEdMMLYoBlCsKs+7c8j9qmY8FslZMIL
 EFlOm9FjACOy3Xtda9lEx9O6csre7DnUbTeFh55YrGPz3SjTkiNxPp0V02TbRUCA
 0p74o3TmseM2c2tR2jt02H4XAXIop11g9CIyGZl+GaPBs3YnvvFTL4tOBifkmKl7
 7VMI7HN7qCyE8JoQTYqBKVgrUzbc7KF4DSUxC5RUw8Indfg/uSaNT6zBvNocmXhN
 fRu+dmxysfXYi1xiI5RGw==
X-ME-Sender: <xms:l9FgahFFfXxmt-jlMoPEmEKv2viqn465IXGlrDsciPsBlaa1-se71Q>
 <xme:l9FgasVNo88VaLU-QX5mCG1dfhln98hwUdE9JdFI8okXm44wusYsSyDCKEcIhxDBo
 -GDVyu358SByMHtpAAxquWZAxlHnooF4o10tp_CXKVfXBpAcOhNKLw>
X-ME-Received: <xmr:l9FgagwRTNxpwIktx_VAKDu7APWfZEyndb30sNXsOMrf6MbV9S7AgXqsw7d1njwfRwY-uQifIkxVnLFky0xn3K_rfQ>
X-ME-Proxy-Cause: dmFkZTENTBuhqVw3c3JHNzCcjpNj8p4yq94J3ZgqJlSYVoFpV6j1ZLTjAj36OlbR67S5zx
 TlxkOcpBl0hIBEFFRgGlGCr3Ddz52UhRt4XQNqcwCWXsORaLdFf0vAlVYq7FfNJ9KzbkAc
 QDbsgNq5THAd8fF2GaAh+yn7snw80QiczZ6v+Ij0xnjhLOF5VJhVJXEg18fzBLrcfRKLJQ
 MOsk5BK0ydYO8AyM0vcQX0u8QOMV1g803hdWtm0oEy+N4ye8Y0yWA9gRqJyr/cZv5AMAzb
 +Si6qjgntoK3GXeeQIQSOGcZvlpR4UpijF17GZrpDSFqtvF+p2YP3go9xn9/odfyNTHJNK
 8uPFjlFMsqI13c4Syze3YOgFHZI5QTe/30aKk7LA/07vNs0gAgiAF85KU76rTH+hEd3QXQ
 1+hpODAwbVaXt5msDijNhv9yzUX0bjAHpyeK+OXHeAt3df1u3gWRYvw/edc7pYU5XAL9ot
 /GQqjavpFhHPD/aYLXY4F6gvQzCTBN9JOK/r5WGe8rQZ7Rs8FcaDylB4GCgi2TLKAYwpLW
 tcZ/oQafQyCjW6eKFuZS+PTNGcIT4cYGaGz4xI1FRYL/eX0kLONOLa1y1DjYpCXx9zz1Oj
 OQK2PCZ0Qlyv5bfvDycas+w5D66diqVRC7mKzvKPwpo1oo+2It1ESNIPk24Q
X-ME-Proxy: <xmx:l9FgaiNTnmpl2F8R27o_FKrWoa99Bv77Wk-9X0pwf1O2T8I25PVkXw>
 <xmx:l9Fgap5VJYxtXR67YADW27WPnsqj12Jg9kQxIwpbOJGg7UabdJphXg>
 <xmx:l9FgarNTEcavGkNHkl5mxfKi-jJfVXJGYtBMZeOZHxsWYcIb8IKpAg>
 <xmx:l9FgavknLCUgdkE70p37Z91pbLOrRNtbnmqo-gvCVciq66mr9AAw9A>
 <xmx:l9FgatpKRBa-3qifUp7TUiM2YwKsmnk3fZgk1nLWGJbbEcVuJ--mMofv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 10:20:06 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Riley Fletcher <rileyf@linux.ibm.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH] doc: Power11 platform results for release notes
Date: Wed, 22 Jul 2026 16:20:03 +0200
Message-ID: <WpxnzKfYQ86Mh4szMOeScQ@monjalon.net>
In-Reply-To: <20260721053825.2434682-1-rileyf@linux.ibm.com>
References: <20260721053825.2434682-1-rileyf@linux.ibm.com>
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

21/07/2026 07:38, Riley Fletcher:
> Power11 tested platform for 26.07 release notes
> 
> Signed-off-by: Riley Fletcher <rileyf@linux.ibm.com>

Applied, thanks.




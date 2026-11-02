Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA360A34CB
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=Ko8la5NZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=CbejQIAS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D6A940E3B;
	Mon,  2 Nov 2026 15:49:53 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 3F20140E1F
 for <dev@dpdk.org>; Mon,  2 Nov 2026 15:49:52 +0100 (CET)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id 5C5C91D0017E
 for <dev@dpdk.org>; Mon,  2 Nov 2026 09:49:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 09:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793630990;
 x=1793717390; bh=APRL8tK1cDf3sqM1Mm5YhysLoJAHPBFPWl3z5zNva4U=; b=
 Ko8la5NZ6hQUzmN/1hn6lVdVi/HmUoAjrXTDx0WwxV47yp0OxOsCdkKw0RN4vUdH
 KsljVk8IJ09GOnOb5vJP1n67RFgSCWV4ADXXrM79PlL7RlEYO4bm3tXsnf98utn5
 eRuZjXejEKFwZpVPQSzCG+02Ho9ucorNGVAsigrKT7Pb3c6cSG8cH4Ds/cVwP8cR
 SD1e4/bg8+mPo/Dw6XzMlWpIbj9uzBDiPyxhzZqhZG3Qs0Ny/Be9HlrcE5y53lun
 S89E2ZO0jgdQ1fjpmAUle3nZj2A6SgjFJ79/zZRstOaogXK6cboVzsp6rlIvI8Va
 MdpUSRTDCjCtMZvm2SNBZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793630990; x=
 1793717390; bh=APRL8tK1cDf3sqM1Mm5YhysLoJAHPBFPWl3z5zNva4U=; b=C
 bejQIASU+AzKwX+Y3KXVpRgaOXmcAjfK6ICBg7h2Hz0DpFTUWJcesbKtWpZvU38S
 MFYFHzRj7y0neMmx/pGAgOvasH8E9hr4b+e2W8bMBV5uzBqmucYcM0E//PRuM6d6
 s0W82IvlxrNYkC2KOtEyFIknKiUGxPyL/9beVxSVfNwZf3fs1Yc4iTCzbyn7KqGs
 h3MMZnl48I7FdiRykgZgxNlpcgsUAX7RF0cWP2NPWR8VGRgCmiRPvHcL6ebSZ65X
 2AjU0H9Z1IN4Q8mO6kHqwmhpqRZoQOF7xBywWNnFcdpO8QO287hQ8xf9yPvwj3mB
 +aO2nbgQoNqzldccgUoZQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793630990; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:ElDriTlVtqnxCiZoQEhsgJEFpxSRblb+vOWh2Gzm7XtmLfQ
 Zplj9fRsX0QiqtEqSbXkWYBqKIGZrw16fCwyn0Dq0IRf+Wqb6fAyogSzE+4coiIL
 TnjvTj2uY5hkPD93476q/czqnu4Ym+ksca/p0yGWR18zp2xJsep2E+Y+b53ipMD6
 0KPGohaLct6SD+z+Fsp4RgwTVxgwqHJMJrz1eEJKVuG8WN0sFJP/n2s691QrS71c
 yx2Ddj3bZ0RJUuvJuYoNTkorqTaLvg9jKK2UoYzzmm+6kUKp/0VYMZG7lubJcEqi
 699VTUCR4qJrcQwnmeuUlV1Niy6RuclpxgNOaPA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:ljATa7PRIZmCEyidxegbwgXyhQqJJQxiExenUNUZeP8=:NyFCVCRiDhsm7dYGbPJp5ASAnahFWIDHX4qVnUEKIOQ=;
X-ME-Sender: <xms:DqPoahct-V4v2m__fJ8Jkd2Rs6350_3vnmiO0xrZx5XN1mLQ8MiKNg>
 <xme:DqPoavVdYNxA6LpIQSlQVwavc_0s0YvXT19U79qgdZtTlbJW9O9odUWF7gg8HJMDK
 jqMHsVkQ236bjzOAhqKrJh59rrlZE3o9IszTgjZJoq8wvsHntbxpRc>
X-ME-Received: <xmr:DqPoaicpIeu143sY_H_Sz_vJfkkSJnoi6_AnlDYrLS0axbiZyfm4_ma-y3jQt5xWR9zEKDak6n-l_0YL16dvZMU>
X-ME-Proxy-Cause: dmFkZTFqc03OxqLnfHkr8J2LhGpf98GSY8+Qlwvs1WiBiMCA45ztX/Pq5dOk1oWy8jjZqO
 fsrtNjB+9ZDLVpK8ZNTvDvFeeuHqMooOvCbokctRaBWzdfBoquS9u7ZwkGqYUqldHPq8/J
 8TGi7IkB88csTDcuo99+Rho7r/ta80DaakURt5VpA8ySbOTJQadc/mGck677kUxjbfVcO3
 3E/GgO08Bot3JpEreBchIYmI8oAkYJtKbE1sZpjm+AM9/HbfUPQV936TrrOTclektagPOb
 uojTdLH2W+82LsN78ksdNhD44dXFtbIYTzFApyWiYRrqq0mH3hKDt1mA6WbJESYLzYxqdk
 Rog6RHuWIH2X8tyUNkXXF/vriMe7I/gS80kL2B7crBkUnDlGQ130UJja6ob36QC8Awk3tO
 XA7S4tF4nX7rjKW8w2fxPbTM4I3B0qwKZhRzQP7a/FWYD6wWAKum92gnAfeiuNLssS25KC
 Vxj0/whXac0/g+h10NJZ/3KJh20cpIFW6uo/gxWKYI1xyKwdDIgncWvArIYOLh8OkBXzA4
 ejTe40TR2I9joFve17l1+bXKdw4sPgzLO7zT2YkHnq+LQDnvqbjuBGSm2d9lKBsHmyl2Ay
 nzhzmUi6ZVTD7V9inN2qB0zNZg4tEnEr6hf08xf9bcZLDaW++qw519fDecFw
X-ME-Proxy: <xmx:DqPoajNQOg2QsJwhE14dcrazRuVED1_Favc8Dz7tRN7V5KIfF8Z8jQ>
 <xmx:DqPoaogF0Jy3yvQfZLEnaGtzcaGDAsMPbNm-8mwuBEZNuMGp211eRg>
 <xmx:DqPoau2YCow4JuVsTQQzT33GNvZ5p3GvWHeLPeeseiC4va9H8M55ug>
 <xmx:DqPoaqhApVPBBgHs2Fqj2KNA4aB2mTHXX3kUPQL7OxXG_hhgC_J8Qg>
 <xmx:DqPoallPdUEp1fQlMrZFLaQVDuTloHKcTm7MHFq1KtQ52btkVCFuoo7h>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 09:49:49 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v3 0/9] consolidate sysfs access
Date: Mon, 02 Nov 2026 15:49:48 +0100
Message-ID: <tR3-FNBgRxOW6UbyTMi5jA@monjalon.net>
In-Reply-To: <aqlYsYvgFaYTPcKT@bricha3-mobl1.ger.corp.intel.com>
References: <20260912063319.4117869-1-stephen@networkplumber.org>
 <20260914173700.2795983-1-stephen@networkplumber.org>
 <aqlYsYvgFaYTPcKT@bricha3-mobl1.ger.corp.intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> > Stephen Hemminger (9):
> >   eal: add common sysfs value routines
> >   dma/idxd: use common sysfs routines
> >   common/ionic: use common sysfs routines
> >   bus/vmbus: use common sysfs routines
> >   power: use common sysfs routines
> >   drivers/bus: remove duplicate sysfs string helpers
> >   common/mlx5: use common sysfs routines
> >   net/mlx5: use common sysfs routines
> >   net/mana: use common sysfs routines
> > 
> Series-acked-by: Bruce Richardson <bruce.richardson@intel.com>
> 
> I double-checked this v3 again (as with v2) by running the unit tests
> against a device using idxd driver which reads parameters from sysfs. No
> issues seen.

Why is it marked as rejected in patchwork?




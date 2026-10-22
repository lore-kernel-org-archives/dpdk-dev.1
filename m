Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E22606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=hBrEZD1r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PoO4JvdQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C00240264;
	Thu, 22 Oct 2026 11:44:42 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 981864003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 11:44:40 +0200 (CEST)
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 136087A015F
 for <dev@dpdk.org>; Thu, 22 Oct 2026 05:44:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 22 Oct 2026 05:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792662279;
 x=1792748679; bh=lJY8p7zk9ElQjcAneikp4aFkLX0eMd5ScbdemVfdKpo=; b=
 hBrEZD1r3kSa68a1BztKWT3vxN4Auz+X9vrCaHdgvKi+76Cm7P8qiqWezWZ+3I4l
 WNsm9gdJRW3RkKSItw1m4uH0a/UPl/xZ1I36vrPgNcwvWEtz1FMZBdiqxUdapedb
 wHNuUMbwgEnzqGEy+gu29LugfWGuj7lf/eJ0s4dh9CtE47HclCXDK1cxv2VJxSg5
 r5FuP7FU3FClAzCsM9ldc1S3AEz6pMeDSp0rRtnuw3Mv0puC+RvUnH2PhnBVddmG
 aW+0y9nQYq/WtaCKGD8KlXZR53e8aix41IRGV/PxA8NfjgsQ65CV5HJdYy+lKjnj
 5fg6u6+7SItZJuPJ4LHz1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792662279; x=
 1792748679; bh=lJY8p7zk9ElQjcAneikp4aFkLX0eMd5ScbdemVfdKpo=; b=P
 oO4JvdQZiGfyT92r+RO8S4i+fYixPLH4G8kvn7XiuxLr6FvSmGV0bDWWE7XzpBFH
 NiZtWkaJSe+i+rZKX3P/fblAXALlrawNjjTzcuF6qi3A55O2aFs+uYsRMxB2DsaV
 2c6vdjLAx61zehc9hSoMqtMntetoAwabkjnWi4NTW+D60azkYGTbUn6DUTxre1zd
 22sZDI4A5jCeUrvIMf9qcdY3+ct45yQlw/hiaeA2AQawPkSN0H3hX+dHozX2RQXS
 6vRR93b6ledpd2cbRzU//RRgJDHEA1pBs47kRSbq3jA1dOVC2GlEKhzKW/NLsVku
 9lVXXKaFEhMKmamI1ISoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792662279; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:l7um0ZpuQPj2lSI0bBGA5bWnZ0Lusbw22Gu2lS75vk+x1UR
 j8y6wN98DDQgCNpYo5RkIFLOT+eZ+OIB9PscG3wvHN0rF0gDaTZA2NotSVKDCYjJ
 ci823fib7hiJWE4Gc8x+lMTLJ7/C96pjx5n8kZWvaf1YmS3yFTCPWd9sV9ZxAlns
 WSXtU4N9wInpaYmDwvOa6UsInfTkAffno3fuRCjAmWNWvqQcGH+tSZRlej/ThIW9
 i5FJdyMinZWSuuJQ/Vj/vCh7y1O+F33l88TGymx0KMQHig/TcwDtmRGb7yHAcPh9
 a/hd9dNL3nd+bEJSGNuoVAg+qyTbB5BwqIkQt0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:s+dNlYTZBGg3mL6TtCEO5aeRLMtmoK632PimkTHrcLE=:dSRsQRngfbqi48DLvhj2gKYvMr4C0l7OtLgxyetTgfc=;
X-ME-Sender: <xms:B9vZaqmJVngdEP6W5Zw_e23n_ycUa-_5-rmGJD9wq5kKkkILd04KRg>
 <xme:B9vZah_043yT_6A5VG86UQRv0WZeltR_expiTE4PXz3YO8lxXT1j4B-IMWTtHQ3gQ
 dD3xsjxyJosiFo2DGIoG8E1uZS8dCAyWiZ8eyOnrVo05ZNzjc_oDFQ>
X-ME-Received: <xmr:B9vZagnVyVYfv4ed9Lqlms3TmJT1JagAueVhwMNrloy0UeXQmjRR721g4k8fM1buz9JqkPqPAXSE3eYQ9WUWhJs>
X-ME-Proxy-Cause: dmFkZTF3nW4/ACm+IDF4kor73D/82ayboj/Z6u6MGuAs1niTxIb1+X40SGvn7wFFe+cyqR
 pSYOTet6VjEzj1YzkWgb3mec72x4cLNDngAFGOYlkSIHZmCycVPvEEjwzd6dXdO7CyNWWd
 Hee27VEs6wD19HCx/JXOVsBVAQ9AlpbRMg/NvtZjWBsjrZxqq3/jeLv9k+xZ3OOCgNX0Fi
 be/CKMd89ijMwjMsYfEtcrzE+4KAWbr41Igu75Dip22w4YGzwfSd1KsjQgSGZq1S6Jzfit
 vlhPFBcf4mJYAZ2YFDIkQ7kda9x5OkzVaZ/o/fgTzK7AvqRdGXq6uo8iPDFmsHjBFgy4R8
 dPkYpMtwAlRwyjUPh0uDOfBt5/vTrKCIEONTtF++sSzH2LQZ0tnhqqrKhL/jK5s3zIN/wO
 qPW1VAov3ZVS6nl2bdqowGojciYvfXL+uB6xNQUkQ6lajRLyvJ/mbCvzs6FPWWKQm7o+76
 Q7kBzhKU3EHp24XujZ+v1J431I8cOGCBdxGVE/n9KusQX4PaGrV+SvOLhJsYkwSCdUo5sg
 h9sNwseqyzo3MXXBrcDeWPuhD45FPXUoHDxhc8dJolGx5YJrxYfC9zPCEAES83sl6mxLqJ
 EYaDnHIdm+IaNwm5IJlXo0KI4KG+GJMY5uQHfTvP59qiGvDDQ9sDW5f9mDiw
X-ME-Proxy: <xmx:B9vZam2L0N53YaLPCvKCXkM-Hod3nngW4sH1Iqi5XA_hTbYuiDKFmg>
 <xmx:B9vZajpZdbjxHmeX33b4XsQOhB38ouv8V0CqCyiABFJi34dVCqW88A>
 <xmx:B9vZarcnuV54aslRSObMPaUxfYjaUowbUbG8_XqIXSy3FMrXSyR_Mg>
 <xmx:B9vZaqqIeaqSfVU_1m_WxHmGKcYIqXFwCY-sVFPzzHwKKChMMIkbnw>
 <xmx:B9vZagZKqBs69U4lcW7uPp81V_7aWJj2_-NJS3XBnQaqWEZEBzsogMsj>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 05:44:38 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Igor Russkikh <irusskikh@marvell.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH v2 07/12] devtools: check VMDq capability
Date: Thu, 22 Oct 2026 11:44:37 +0200
Message-ID: <Nskh3lQbTOWC4SgPkE2x7w@monjalon.net>
In-Reply-To: <20261021103027.2050351-8-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261021103027.2050351-1-david.marchand@redhat.com>
 <20261021103027.2050351-8-david.marchand@redhat.com>
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

21/10/2026 12:30, David Marchand:
> --- a/devtools/check-doc-vs-code.sh
> +++ b/devtools/check-doc-vs-code.sh
> @@ -78,6 +78,28 @@ driver_code_dir() # <driver>
>  	esac
>  }
>  
> +doc_code_map=","

What is this comma?

> +for d in $rootdir/doc/guides/nics/features/*.ini; do
> +	drv=$(basename "$d" .ini)
> +	code=$(driver_code_dir $drv)
> +	case $doc_code_map in
> +	*,$code:*)
> +		before=${doc_code_map%,$code:*}
> +		after=${doc_code_map#*,$code:}
> +		drivers=${after%%,*}
> +		rest=${after#*,}
> +		doc_code_map="$before,$code:$drivers $drv,$rest" ;;
> +	*)
> +		doc_code_map="$doc_code_map$code: $drv," ;;
> +	esac
> +done

Please add a comment for this block to explain the goal.

> +
> +docs_for_code() # <code_dir>

Even the name of this function is not self-explanatory.

> +{
> +	tmp=${doc_code_map#*,$1:}
> +	echo ${tmp%%,*}
> +}

[...]
> +all_docs_agree() # <driver> <feature>

all docs agree on what?
a doc is supposed to refer to a single code path

> +{
> +	code=$(driver_code_dir $1)
> +	first=""
> +	for drv in $(docs_for_code $code); do
> +		d=$rootdir/doc/guides/nics/features/$drv.ini
> +		has_doc_feature "$d" "$2" && val=true || val=false
> +		[ -n "$first" ] || first=$val
> +		[ "$first" = "$val" ] || return 1
> +	done
> +	return 0
> +}
> +




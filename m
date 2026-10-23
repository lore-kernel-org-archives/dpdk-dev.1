Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC2606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=ZkZePN7X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IhMpuCxT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C5C740299;
	Fri, 23 Oct 2026 12:13:35 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id CE31940268
 for <dev@dpdk.org>; Fri, 23 Oct 2026 12:13:33 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 489561D00140
 for <dev@dpdk.org>; Fri, 23 Oct 2026 06:13:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 06:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1792750412;
 x=1792836812; bh=PrTLIqdkFDG91BOfvi5XCfrQtPd1j3qV16kMAwvp+kM=; b=
 ZkZePN7XAzZFgwxijYG2u+WoYwiQWty4OFx8ywI6PYQLSHcVaSdwOJqxtsqd6GLF
 166XqzVEIsWAH9F/VcZ3A5//uKzUsBxsleLFQU5MZz2XznkwSSx2n0fFqgYjZxQw
 zvRclIbsBtV8NCCcMzcpOWCnmcJEppYs1SPsnF7L6dEysMzw/0aGt8RHG3c3xOqw
 T3xtRgRxIHQB95s0TF++OK9+9dYe9/RAk08pApHF4tE96ul51VdpZHEK3NWowBRQ
 Xcm+lJxV/kvuNe9auzm41CoivN6KLregltwHFZXgVz1KCDy8tFX5PtrW4biECseq
 8/2tYt/5FQYqYgH4WZxf/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792750412; x=
 1792836812; bh=PrTLIqdkFDG91BOfvi5XCfrQtPd1j3qV16kMAwvp+kM=; b=I
 hMpuCxTH8emmXzUrnVA/YTKs+TIkKUjSYUxVzMD9PM/wqZbpbB+F1wfOnOQRHRPL
 mdSgfG+jWdNUR8EKLFepFGaOYYDd1+Zyl/RKEHnFnLbmoZYojQuZQljaiRg1NST3
 4mTfTWTa+0BHKK6WPHyIHZUiSleowBSVjr1Bp0OMcXMl7652z609qXH0zcd1GbDw
 WFIrQ9If1QHoYZorkiaoGNwVd3xWl7uxeqIZFhcJ+co0uPh5/GjsEPEIq2/FW9p7
 KdDk7F3bMIh9nriyFwtlbDmzGd6I2+EqHOEKpnuFQr/vtbpOhxC4FBcaKp7NA+8n
 bhU9gT4Cy2VkuspLu2jfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792750412; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:gnaQnDJAZaGNVKHVNCjpM6j6/6Hz3XjFzsKAWpQUdAJiwUD
 LZMsMdf6sB59JpW2TVudHSliULggyYufjACm/Z/GL2KhIX2jeEOvhUgfebyPy4RD
 F21LFsa+OJf5uX6EorLQf35sOxHeE+n23wrOleFOp7nE7qaW6l+Hryp3lQRi7A0l
 7OxRLW/FrPoqj14nb0lB94ndPc2xPdJ1gG3PmLgjAh+4tl9An/iUNryKxCrVlsIC
 Wx5IIowb0+zhWNsgWiExUeHgypTFfy1ZTJuH8fQi4G8n6B58HaaTD+aVu0cf6CU9
 n7jNGHBsAP71mvfhwS/8bJ3/f7EUEh63FTOjyxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:aThsI8l7QzPybYkuICkuLj46VfllwQ0TG41GClya0NY=:MsLHsnAS3Z1LIjGL/QqsOlNhzO6xKEKzajTMaKDK8Q0=;
X-ME-Sender: <xms:TDPbai8PjdbAnB1jrhQTRqHpS7_BcaUzVT4jXsP9vDI4L2HwlZjvLQ>
 <xme:TDPbanCcn3SXBhSYjGyzaNnCFvODNu83-M1TkZq99xfpnct0lmbJfAZSEFlW_O4HT
 0KvdLlLUaAmCzxXWkSwa8upy-GCpj8FrzpTwMNPr0t_UrxYlxlY7Xg>
X-ME-Received: <xmr:TDPbanLuVkFfaG8cc0rSjT7vt9B9BGekncmwmc4jt-iKGeYHrBB2L-DKpRO4kXvpxWTGXSjVdBUQ6wGv3EhjJlo>
X-ME-Proxy-Cause: dmFkZTFC2hLZioXDhArWVDKtxjKYL/gjhSNKS1bKRS56nCpAv0aZlEg5hp/ZTXpZ5pRfXV
 aI3a66GNO5Ath8yY1s3daRSDtsmVhuOajGYah1wCZ5iY+TpD63U8Q52MVUrNb3s70yNE4k
 iiuR23bGSTxMGi/GmSGM/1091lAsT4uXd53BXyI2RK4+nmCwxw9YliNC5qJdd7lOq/f8Pq
 KcOlHcTrPYyD4F47AyN9H75yYWgQu4/Jnu/cmrCVe7B69H7Exd3kaW+Ovzb7c42koQUCco
 xYp9BpZ9DdcHJ89CzNJDxErWtrVCze0vyuQeZEqBOxTU32GTrFvI2baYvhLSyPqlfKWRbz
 10kr7U73UFNV7IfV7bDduvPjadsGxcjThuxJlmlCXqaqCG2mQUJQiBFbhF45lzZJ/OB0Ww
 o+v1yzfFGXlWdnbXFsJW2L21StVgdz9IaxRpOa61elvo+Fdd6RwOacAVxDMEYDG6BYWuUE
 dBT0WrM7ptL0RoJ+q3zjNFcruMK+g3aZ7Kr9aIZtyo1y3xSw0MNgI4XGuZAgo3fZ0b+aHO
 6PstnautUwhC+bDnGSR5+1fvSaf9WqRtUDR08rhgd+bJZcc7dZ1RMFGDISVU4Oh6/UrcJm
 mDXFCkuA2VyGIXkaWPrA94fePXkgyaR2NWCxijJ22U5nsukSijgGhrpiGHbA
X-ME-Proxy: <xmx:TDPbainqJ0tXzSmOIsJs7XzhJTMoN6mbINg-PXF4svZx6lnmfHYRLQ>
 <xmx:TDPbatGRqXyhJsaJDdvevYfK3wuDT77oUALkV_uRah8W0f3yNZZttA>
 <xmx:TDPbaqFfqwBklNdSGhLL_fRFqugoxCqdxPlMQQBllat_c5EPDNuanw>
 <xmx:TDPbaiPZr3GAhroz9ajH1cOtVTZb3yj8AJTGXFNkQbTzCzwb-ax9Yw>
 <xmx:TDPbagB9_EIlSyiRlLez8LIkqz5SDNtaCv7f1UuQZBSeFXQ1chIkFbtT>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 06:13:32 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v3 04/13] devtools: handle multiple drivers in doc check
Date: Fri, 23 Oct 2026 12:13:29 +0200
Message-ID: <nGkyRUDCTUiARwHHOBzhIw@monjalon.net>
In-Reply-To: <20261022174447.412638-5-david.marchand@redhat.com>
References: <20261016130555.1685102-1-david.marchand@redhat.com>
 <20261022174447.412638-1-david.marchand@redhat.com>
 <20261022174447.412638-5-david.marchand@redhat.com>
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

22/10/2026 19:44, David Marchand:
> -	report=$($selfdir/parse-flow-support.sh $code $doc)
> +	code_support=$($selfdir/parse-flow-support.sh $code)
> +	report=$(
> +		for category in item action; do
> +			section="rte_flow ${category}s]"
> +			code_items=$(echo "$code_support" | sed -n "/$section/,/]/p" |
> +				sed '/]/d' |        # ignore section title
> +				sed 's, *=.*,,' |   # keep only item name
> +				sed '/^$/d' |       # remove empty lines
> +				sort -u)

This parsing is used below.
This is an opportunity for a function.

> +			doc_items=$(sed -n "/$section/,/]/p" "$doc" |
> +				sed '/]/d' |        # ignore section title
> +				sed 's, *=.*,,' |   # keep only item name
> +				sed '/^$/d' |       # remove empty lines
> +				sort -u)
> +			{
> +				# items documented but not in code
> +				items_not_in "$doc_items" "$code_items"
> +				# items in code but not documented in any doc for the code directory
> +				all_doc_items=$(
> +					for drv in $(docs_for_code $code); do
> +						d=$rootdir/doc/guides/nics/features/$drv.ini
> +						sed -n "/$section/,/]/p" "$d" |
> +							sed '/]/d' |        # ignore section title
> +							sed 's, *=.*,,' |   # keep only item name
> +							sed '/^$/d'         # remove empty lines
> +					done | sort -u
> +				)
> +				items_not_in "$code_items" "$all_doc_items"
> +			} | sed "s,^,$category ,"   # prefix with category name
> +		done
> +	)




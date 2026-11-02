Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD3606A326
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Nov 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm2 header.b=KBsCCIa+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E2ukO66Q
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D5DF40E36;
	Mon,  2 Nov 2026 12:26:52 +0100 (CET)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 9341340264
 for <dev@dpdk.org>; Mon,  2 Nov 2026 12:26:51 +0100 (CET)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 75307EC022B
 for <dev@dpdk.org>; Mon,  2 Nov 2026 06:26:50 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 02 Nov 2026 06:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1793618810;
 x=1793705210; bh=tjdePTdScZB3KzBFjfTNq22MwoPUeTEr629DSkmLT4I=; b=
 KBsCCIa+D3Kgiy9OeR443w2QqZgxZRlvRHZDlVMzHv/AaljiLF7iT50OLm3XQTbY
 kOKCMKLAKDRUdOCLQbJkALnhq5PDS3pQptp7OG7821+3iqlpjDyfeQYe4NlwS3kM
 /iCZdZBUacah9zXjXEawjgxYeMeQyC9UicW9mhyot5yHZ8kmJ5v6Zns5h/hS+ddG
 6GeQSH7Y73W+O3gN4gKhjlq6Jp4LgC1ulA21Lb2vDo4BCFcUG88Zgo6RunuYBAJM
 QJSBKv+Y8FivWrNPbklDvHcfvOYWuya3VfOtiWfYedPed9SZGptEcVnOXdvPRHv3
 j0bws2TxT5Vd/fshJwYaVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793618810; x=
 1793705210; bh=tjdePTdScZB3KzBFjfTNq22MwoPUeTEr629DSkmLT4I=; b=E
 2ukO66QIVymW0Qwu9xRyYyqHJbCpIN66vwpQsZz3p9u8zhfMaHoiSTkt1tNHdsbV
 4eOPfNvc8HAmWjnNqEF7/PmKTiItJI/PpIZR4GjKidE64zQOVW7zwZNOea+Tp4jM
 5o602EYCV7tKy5znEXY/74qKAbIXMP0p3sidZKk8JFtvhcz6z26asl2hR1jXdDVd
 uk+3vKHzjGUnufy0tcTfNXfuD3BWHUmWEPKxkgDq1kgt7cHiJgLYBgzdRY7gLB4F
 BiyF6aWd8myUuLCJ3FkfVyDQSDNu5tVueKBfNt1jzJNSUXwW0RRk20FlOlNg28kU
 xxhudqqLSZVOnE6IxlrBg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618810; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:bVoXd4y+AKB7iRsGEmm9TbYxns6FYjsGDNTTRRcnmNCnM27
 9EPLwX6qCI0TJ3EMZRNm1cq51jhp2o/0gxKg82dkX7CaErQgj5VqHiyGtdIOgIBP
 aAxa16NI9suCLG3x1bfl5LvlRlnqIbOvgI5+3LJ1MePUqs93vQ1OceEcISDfcGRA
 DlttYY0lcRzWiAY3tHj29z6klhpzHPZciVuGKUkm4msDUS98uzUODDgyyIxXfc+Z
 X+zLsU+SpZYquqAAEYshxn11crCVbGW2oqFTEibasO9jOUSuiClmoN6szGtWBxMm
 gJOhxDuCw7VwMzJG45Imv951huBcqwP0B8au/FA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
 repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:UPBKvDtHPxDZNyT/CnNU1UyriS82D4cIpPdPSfuETkM=:Y4/JxxxtZsJSBrx1AA8xWjOqumop+qV+C+ydR0OGYjw=;
X-ME-Sender: <xms:enPoauRCzoJR1HBA9Bx4ncbQ09bjsIyATXoV3262HiKiosThEkr0gQ>
 <xme:enPoaj7UrG6qEICWK-BmiTOgsNCdQt2y0F3jCLzyCV8eCGkncx7ARw53x-DdI7hFt
 q_yPcGup9ZG67q0L480NE980GUdnJp5Mgy3qFxlejhwm83tvc8S2dV4>
X-ME-Received: <xmr:enPoajwcQUF0yyYHXA6TU2i9RZod1H_spLtAkn8_jQpnnhfdBPqxpJtO9e2IhkfJ7X4BkwSj1x-ueS1aiW1Rmjc>
X-ME-Proxy-Cause: dmFkZTFK3NQ8n1eLjEL43DEWlEEuEZXiIEcgscHdrIkA/VGFeVM/Q9KiW9HvwWw/9unkio
 rZ4HRkcuvBbTrTeIfcxaGaAXhb+9LRjCjeDLGicTKbz6kxkGSyTdB4TDWSoCtqzb3zDGn5
 rjZzUCclgyqS1il7R81Hvpo8OWrbwL1BTwWtGT14GEKPHGha2z71aoMmi+i2kpcXWtREVf
 uB91vvuBZ4FzECNfskxeHiBSpIE9dS/FH2ZEXgLu4VF6YVligOsiCtj2rhBAdovTRJv4zx
 O0LHcd3DbY8nxv4ZULrqyK9po/zMhP2gOHgp3LNeOG9Iuh5Sgch7lY0Y3scI040LWPrMUK
 ySq3ZQ/QvZKl/pcV1gv8cDtH2B4QToNZ2LTUgWp9vAwPIc9+aSWrdHB37sKGPbnB4hJO0Q
 vojISptYozfd5BVo9JhavVuUBxQPPHpZisvb+HMY9W+PzaM/aLvaEkotn728+ZDhKpzqRM
 Z3InyQd7I70LVG9or9+V8HHLc8p57ltfHSgmH5pKOoTXvkGLHz+5aJ/l/Z+67FnoEk/PJa
 +xRXM5Bdkaqd4lQ/+jFkUsJOBl2IuFo4i5FB5F8CSLGomx86/9psDlGZGGVb9/sdsmMpq4
 7tvK2ftIB3sQF6nYrKjITAz2B9b8M1nsQ61aqnPBtkgPvi3rw0AOLaWX0f2g
X-ME-Proxy: <xmx:enPoaiSulbqOxlIDgqi5xKFpNZ726pxeTTD_EmKRjuRlMdRJfdzZBg>
 <xmx:enPoaiWLSRvbftfNvFFgeViJ8LLFllzxxKOHLVGP19FW-ZbfQ2yWVg>
 <xmx:enPoasaKj-YMMIo4GifXSb01Pzrc-gfM_a4JOfS069XPaxRZa1ZbgQ>
 <xmx:enPoag0wlXGBobggwv3CGHNi2oG7uaSxKzjAomChTrjWV_UwpyLMnA>
 <xmx:enPoapSTyOJQtsQMBLA9wPTaS3I_uQDcxpkaBFENkzy1pGjJgc4jOwfO>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 06:26:49 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jiayu Hu <hujiayu.hu@foxmail.com>, stable@dpdk.org
Subject: Re: [PATCH] gro: fix packet type comparisons
Date: Mon, 02 Nov 2026 12:26:46 +0100
Message-ID: <bap644fIQUuKh2aoval4oQ@monjalon.net>
In-Reply-To: <20261017170221.3139971-1-mb@smartsharesystems.com>
References: <20261017170221.3139971-1-mb@smartsharesystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

17/10/2026 19:02, Morten Br=C3=B8rup:
> Identifying packet types requires masking with the mask, not the value,
> before comparing to the value.
[...]
>  #define IS_IPV4_UDP_PKT(ptype) (RTE_ETH_IS_IPV4_HDR(ptype) && \
> -		((ptype & RTE_PTYPE_L4_UDP) =3D=3D RTE_PTYPE_L4_UDP) && \
> +		((ptype & RTE_PTYPE_L4_MASK) =3D=3D RTE_PTYPE_L4_UDP) && \
>  		(RTE_ETH_IS_TUNNEL_PKT(ptype) =3D=3D 0))
[...]
>  #define IS_IPV4_VXLAN_UDP4_PKT(ptype) (RTE_ETH_IS_IPV4_HDR(ptype) && \
> -		((ptype & RTE_PTYPE_L4_UDP) =3D=3D RTE_PTYPE_L4_UDP) && \
> -		((ptype & RTE_PTYPE_TUNNEL_VXLAN) =3D=3D \
> +		((ptype & RTE_PTYPE_L4_MASK) =3D=3D RTE_PTYPE_L4_UDP) && \
> +		((ptype & RTE_PTYPE_TUNNEL_MASK) =3D=3D \
>  		 RTE_PTYPE_TUNNEL_VXLAN) && \
> -		((ptype & RTE_PTYPE_INNER_L4_UDP) =3D=3D \
> +		((ptype & RTE_PTYPE_INNER_L4_MASK) =3D=3D \
>  		 RTE_PTYPE_INNER_L4_UDP) && \


My AI is not happy:
"
The UDP checks introduce a regression.
gro_udp4_reassemble() only processes IPv4 fragments, but the new comparison:

(ptype & RTE_PTYPE_L4_MASK) =3D=3D RTE_PTYPE_L4_UDP

rejects packets marked RTE_PTYPE_L4_FRAG.

The previous check accepted them because RTE_PTYPE_L4_FRAG is 0x300 and RTE=
_PTYPE_L4_UDP is 0x200.

The same applies to IS_IPV4_VXLAN_UDP4_PKT():
requiring an exact match against RTE_PTYPE_INNER_L4_UDP excludes inner frag=
ments,
which are precisely what gro_vxlan_udp4_reassemble() processes.

Could you preserve fragment handling in both UDP checks and add regression =
tests?
"



Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13A4CC6B12
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 19:41:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE37840272;
	Tue, 13 Oct 2026 21:41:53 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 by mails.dpdk.org (Postfix) with ESMTP id 0E5C340269
 for <dev@dpdk.org>; Tue, 13 Oct 2026 21:41:52 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 6B83AEC04E6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:41:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 13 Oct 2026 15:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791920511;
 x=1792006911; bh=u8Ejuf8FzrHt3hM8T/Jdm3SEd2DTzjnlFwNI+8bikkM=; b=
 oYZ1I/soIJPcNIcP0fkBaXfi/UxoM6eP1KYG5ss9MzRNKtgc7dTI8CJFRTyPPYlM
 fwdc1VERvlLJJr7EyRKBCLk5xyfycqvIiscN5s7kuBtN4GEEnJIGGhuUJ5hjrQ3Y
 WWemfII8Gnt8A6/m5v/Q007mdAoM0r5IvQDv4cf/gLa5DXpNV5XnxlDV987QItk/
 wckpCBHqN5Z2TBItfHgSN1+8uwh9PW8OmXW3ogkQmUM5Vkn0U2zIdngzPjAk4PK9
 Px/S47gi4OpCTX+exT9GdS9elOMbfFikON833Bcn4dLzcxe0A8B5wQva1C/GLOFD
 vKfejsGsreKGMke++M1RHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791920511; x=
 1792006911; bh=u8Ejuf8FzrHt3hM8T/Jdm3SEd2DTzjnlFwNI+8bikkM=; b=N
 C9jKLceOxc/IsbFH2MloirEdofSW90dvWqj/mTIVr9PNmu0zxa0N6qWYGUtfTTsb
 eXo15mzHYhj+mbRGCELbBw4755CBPGGpg1SbdrxlaX8xMQ6UDFT7GzEyM7DlIxTY
 3/jsh+uDIqWiwmPYGVASEzxPiKBVQd+FrrCkLGD9dsR82UwZgwrhmbyWoc60fY0E
 kXO3BXx1GRC28eXFHcUgknmuUMrFPscpnNRnCgneLM1pOvSDoScehoxFZQuX0fph
 qwC+xOn7LAb6TWepJWhi17v52bmKhb0iaeHiaC8FpqIT7UwQuwFpg2BKutmtjjco
 6LuKmjLAvsOdFTEAJ45NQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791920511; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:FYxcdAwg3ZCLBx3fQJzNiibyEyESn8nP54+u9771hGK4gP+
 Cd7lYSCRsddcVO01KqKZKR75tLhR/5lFSomj1OsXs73MWJCJp6SibhS/XZnDgdMW
 iO1ULRa+nrhMvOWKcHDNrMC3uMrdbgC9LiDeTsOL0BI+nU4TFhtsebxGiju1/5u9
 R/lyECC5o43R0PDNIxHGceCgt+g/JDGh6dwNOM7OUkNoeJqc4BysuSfVxRUwt4t8
 DinSY+TR0aTQSbx6p7nR2RJheCrOH+ldXhRrP9YCQUpKyR+c1drBnEDw6JZCSwnd
 LumE8N50aEP6U52lBBHBZjZs26tqmMGGHmfI/ig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:GxPiLLEvbp9TjqYo2uqKjicA9V8BQWjiyFCEXjWVD2I=:qslHSWkui0CqyAEqdHcvI8/BlBQyqcJctujUGz+ntRI=;
X-ME-Sender: <xms:f4nOaldVzQQViaX_0Z5JjxU_SXZqm-q2wLWDOLYawLpNXRVsQ1NKJg>
 <xme:f4nOajUB367-lXUL8WZtcFp4B7Yw9y0Pc6rlxbxisOfwWw1APMA5JfuzM0rZpuGnS
 aeZKoK_kSSa0NEaD6O4xcw4Irrh1zR_J0SjbmVrLOibFADIzokkf-w>
X-ME-Received: <xmr:f4nOamcruFAPRR-rW-35TPyQh4hk3UKrYOuBK71eqAu-FQ5vfzpw9c_0TpYOV4SEqvkxNp-rfurRkJEyiSnq5ow>
X-ME-Proxy-Cause: dmFkZTFRIM/Q8EdBEBoJxf0fxUvEH+9yW4MHgs8kAmepUgf+dBzkr59ecXt3Br9GgKpa6h
 MVUHRRw3ecrJqqZsh7gD+3xzAIMV4loSExKHAZfr1Fn6ZRUKcEbo4y6A5HQWfT1Gtujs5+
 C7qt/hf/hswFEB9VxUqQGhKD6tOp2PQMngvSa7fauhj05JT/uREB+/mLGiSBeyDaIzBpZI
 kNdkrbpIkqpKLoTGYV98nXBlhBZJS83zPdLXwAtV/BJ0wVpt9/ZQ02IkwCqJJFPIpOTd6m
 04d1rZ4/6C7iWynie/4p71jVSaAO3hFfHrGEwbOGgIQjcUfXWUKUto+KpACjlE9ho53yQH
 WjbkfytoFgRZZdwuX52eY+lG8qNlv3MdYkzMJsdcq/pHzuGO37qjYynYIVzrGeDwb95KsJ
 6JAsQLgJh6/IzjiLGBWAuNw5sp2gAF8WUAZtiIjdryWP03faqu2+2XdO4Z1uAQiFr2qErQ
 6tGm8BOOjJmMWuTKYhBKG9LNZgrnkP7eegD5bp05mziVNOO8q2piiUgTr32BREgcny8VDX
 RpXQfozRCbi5uftMd78sYIbchMp6qtbu0qLrki7aLcwNdnq34ErZpk+hTthmeihoLJ0qr3
 5kfUa2HSUHFLWiWGAq+RKLFkZ6swnLcdkPFpbI0t6AGj3liiIr7T1UGfFegA
X-ME-Proxy: <xmx:f4nOanPFi43VoNaV5a1sDiY3_x4vBpdqt-wEKinLLvI2drdJeGWbzw>
 <xmx:f4nOashx1gVlKrAuONRpi7w5wERK-TkAsqhv59DLG4JD4zJSFOuLNQ>
 <xmx:f4nOai0wCFRg3Apn5BpSe6EGjyfTsY38kfOdo4mbENk2zx2WBZKWbA>
 <xmx:f4nOaugmgj__ckIT0nea8BajOx4QcLhvTSWI1o4kz6Tb70G_mXNDaQ>
 <xmx:f4nOar0DDdxgfzVQ6M2YlTxZf3B06p9fX0pp8DIWeLOdKm0ctiJQUGPY>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:41:50 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: dev@dpdk.org, Kai Ji <kai.ji@intel.com>
Subject: Re: [PATCH v3 0/4] crypto/ipsec_mb: add support for IPsecMB 3.0
Date: Tue, 13 Oct 2026 21:41:47 +0200
Message-ID: <Fb4CjKFWRziKn9hdw7IRLA@monjalon.net>
In-Reply-To: <20261012135947.1895429-1-radu.nicolau@intel.com>
References: <20261012135947.1895429-1-radu.nicolau@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

12/10/2026 15:58, Radu Nicolau:
> Intel(R) Multi-Buffer Crypto for IPsec Library released version 3.0.0
> codenamed T=C3=BAnel Pablo
> https://github.com/intel/intel-ipsec-mb/releases/tag/v3.0.0
>=20
> This patchset adds support for the new library version and support
> for the new algorithms included in this release.
>=20
> Series-acked-by: Kai Ji <kai.ji@intel.com>
>=20
> Radu Nicolau (4):
>   crypto/ipsec_mb: add support for IPsecMB 3.0
>   crypto/ipsec_mb: add support for 256-NxA4/5/6 algorithms
>   crypto/ipsec_mb: add support for ML-KEM and ML-DSA
>   test/crypto: add asym test suite for AESNI_MB

Sorry I will give a defensive NACK
because you never fixed the problem with the Arm fork.
The crypto branch is already not compiling on Arm
because of your recent change for IPsec MB 2.0.




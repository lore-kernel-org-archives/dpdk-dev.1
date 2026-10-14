Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01355CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 12:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4BDA4021E;
	Wed, 14 Oct 2026 14:16:41 +0200 (CEST)
Received: from fhigh-a2-smtp.messagingengine.com
 (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
 by mails.dpdk.org (Postfix) with ESMTP id 23B7540144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 14:16:40 +0200 (CEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6B86514000F9
 for <dev@dpdk.org>; Wed, 14 Oct 2026 08:16:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Wed, 14 Oct 2026 08:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791980199;
 x=1792066599; bh=C0OxsmDI629RoZM+l4uS3SqSKVuDJHgBOWtU521RMMY=; b=
 EB1TdgtrDghujF7CrzjFtsc7rzHfGF3LQzPw4uwrelGsZTcZAiKyXFYnD8sMaJSJ
 wvHe/TS6ISpFfFFIqg6eyeGiBCbgeQFfT+BhPvZzFEwpwddJsAC2CwC3XgrYKISl
 opqT16Q7D8pgFLSjHc1nybboNuaaEGgjfTGpDjz59D2AigKOT3PFQ48WzUNeCuvM
 18w/IE1+zIdLmhFW/yTWsGTO5lzMkHLEAH+je7phFd1P0NjVnSqBizl52BkRsDqd
 MWzsz0nrfc4srwbiQsrPHu4J/yk5JomIZt2Zt7yHuaTMCmOm3uwlYVQYjO7bkO/f
 ZJHfyMyDHL79BqWKh5qy+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791980199; x=
 1792066599; bh=C0OxsmDI629RoZM+l4uS3SqSKVuDJHgBOWtU521RMMY=; b=u
 q3spztCkIMPCj6ViMoj/7pYGFSpWe70jpbBswLJDrBFg1o24OT81hUCrAwdb2RuO
 okMB/UgFxNZjYjzxbxJReLYZ4bs/8dfOlj6XOCNeBNhl51OlGPNfav9Svzh0CHGy
 yW3nC97HOpuLFEhh0qriL4heyev4GG85I6V1AsHlFDZrxv0F55BGOXsvj/Yhs7wS
 XO1agKwbDZhvMmbUTkPhERM/Hs0HCO9fzcx3SNymoAZkXVNNwLdMUy1FO63eCyRB
 F1ZUgNwisLvKI7LvVy6oGf22J89d8XbV7pRqIzAE1Pvgw3SWtt2la5Nu57dg5ykI
 +ECvAFNjuRNBdy7v7huBQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791980199; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+; rt=PGRldkBkcGRrLm9yZz4=;
 s=fm2:rsa-sha256:S4cFoFmsNFxvxVT98nCNwEAfNvfeyyJIl3FwBnsYL8bpE3n
 ij9jYi7198KAyqzdM6EIpqwMR5x7gwZ00eOrl7i2NDEbAAOetu16y4XGF3TdwnNz
 1eJGh4F+skMoApwko7WCb/nNxPTS0kq3dvsJ4lRggIkvpytNHsYt1SbnTW6AE89L
 RUVJ7+cDH9E8BiQpYPYWqx/9REJJprXR67iBI7VnUu+/qSjTtW7YNh0b3mIUZ+Y1
 eKaOGkoM5el8Gm2or3HS/VOiR8c8y42cX79CT2y4NKTlJ/YgMoz1AqHW/cWbBhf5
 bzvH2G4jtet8pndgArAu9j3OG403NRXtv+6r91A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:DZKPOHhM6w6RJhM1dpG4I+e8WYOOo3twkoNJ+N20Ndc=:1WVsi8ZetypCjRGUc2/WkzvQOmdy5N90hxWkK5H+UQs=;
X-ME-Sender: <xms:pnLPahMTyJLIkXQ5NFhgu7Tsx3xHMNuna0PJFE1z7n5Ju7W2C3umJQ>
 <xme:pnLPauCQJKIvYo-XoAyJCHLjVGdcDXHRTFwX7G2c44qrlaph6f_aqIwm5Xx8bMpJa
 _y36BIEwEPBAdFk1DjQMBsYYRL9zmuxjnVg-1CNDP2zuNa6mk3VLmw>
X-ME-Received: <xmr:pnLPagJLFSYBcgzFWlz4ltNmvHMr6Lpa3c-nl3et7Zdhmkd02g4Jyn6Nok2ja3_pCAaquzQj1b2ZyZPsqu98EzE>
X-ME-Proxy-Cause: dmFkZTEx158lFfDY68sdhvzKOKAv0l13hP9coCyydvrtUj1S1ZJf+2PpGbMHdYigKV/q4W
 Z8/+IkfklXW9X+Rus3EYx9RutV6gncTvruiNPhvA2ZqkWAJHalBfiFvVYRLumtPmcZQoLs
 UEbI4VgU0C0u+NKlj/ClR8fY1WkIlfBVUcjAfg23EHRSvHZQPrqVxwPKM9517yV4Cw4dDE
 2F72gyHGoN6gihFpQGoXN1F3RXAGr/Qm1cxCKseLSadzmxmCb8ljKn9LOEskzsT55PGawA
 67Yfx0bwwU60CKsfXY8ooet2lI+GNDj9GPhgQlcjPgQhd2oJJT35pu/FHdO2R33r9yhqZI
 mJmXDY3kNbxjGyBIg0TI/qoatpqhUIvbCQEXpqWrLXLBQAPbgahKewy5J7Fq0mcFvq3zXq
 O2aWpeE/SC+mopPzkrGyomWNGayQK4EUwxhhJO4IJKczNQujdR6XbVkGiscFNcD6hiHF27
 p7XsdJEmdbJFebT4v1vRA9oJZcFdji1EhU1CamwhvOFJO0cQ7VNrMANJcuTMVJ6s2AAtHJ
 6MS5Agf7/Ajjeuxd2dDw6Kw3soc4QpDjHDt5ZQRCr1VPftqUoDuwVsAqgYG5Z6pFIVoCjk
 guYmrvKHLzzAaL83b0P9khUhopEF/RB7TMYDLSyygH4+9KdDAyo5Mj//K6VA
X-ME-Proxy: <xmx:pnLPavO2tch0dqUE978VmdO54F66IM__SQkJqncZ83oMPip9ZHhodw>
 <xmx:pnLPam71Ta1EpL8L9__cj1Ai9mhNuTanfn4647rgXpkeiEHx14cmgw>
 <xmx:pnLPap5xA-9sRbaiMVqgSxyvv4O2MFaRQJPcC7OtrXVnIEzpobm7Bg>
 <xmx:pnLPasHiccZ7HSCGhnRH-JTkLyAK-hamlNoTCQMTh2txDLpa4laTSQ>
 <xmx:p3LPaqOMEZbpTuRIOpvdlKpcoAoywhxs2v--rheZ3TcMyPqWEbPouR7P>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 08:16:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Radu Nicolau <radu.nicolau@intel.com>
Cc: "De Lara Guarch, Pablo" <pablo.de.lara.guarch@intel.com>,
 "dev@dpdk.org" <dev@dpdk.org>, "Ji, Kai" <kai.ji@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, David Marchand <david.marchand@redhat.com>, 
 Bruce Richardson <bruce.richardson@intel.com>,
 John McNamara <john.mcnamara@intel.com>
Subject: Re: [PATCH v2] crypto/ipsec_mb: require minimum version 2.0 for IPsec
 MB
Date: Wed, 14 Oct 2026 14:16:35 +0200
Message-ID: <1ZyWCFPKR3SU1pTJ1PHaEw@monjalon.net>
In-Reply-To: <9a235219-aa8c-4372-8a61-d2ca9d731604@intel.com>
References: <20260811112636.4106950-1-radu.nicolau@intel.com>
 <0UZYeU6OS3OoPauzypyoiQ@monjalon.net>
 <9a235219-aa8c-4372-8a61-d2ca9d731604@intel.com>
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

14/10/2026 11:37, Radu Nicolau:
> On 13-Oct-26 8:51 PM, Thomas Monjalon wrote:
> > 24/09/2026 13:18, Akhil Goyal:
> >>> From: Nicolau, Radu <radu.nicolau@intel.com>
> >>>> Increase the minimum required IPsec MB library version to 2.0 As a
> >>>> consequence, clean up the aesni_mb PMD code.
> >>>>
> >>>> Signed-off-by: Radu Nicolau <radu.nicolau@intel.com>
> >>> Acked-by: Pablo de Lara <pablo.de.lara.guarch@intel.com>
> >> Applied to dpdk-next-crypto
> > As usual with Intel IPsec MB, it triggers a compilation failure on Arm:
> >
> > drivers/crypto/ipsec_mb/pmd_aesni_mb.c:24:32:
> > error: 'IMB_CIPHER_SM4_GCM' undeclared
> >
> > I have to drop this commit while pulling next-crypto in main.
> >
> > Please find a solution.
> > I'm still advocating to merge the Arm fork.
> 
> Hi Thomas, the root cause of the build failure on Arm is their library 
> fork which lags behind, being at 1.5 release which is at this point 
> almost 3 years old.
> 
> The only solution in this release cycle is to drop this patch and rebase 
> the ones adding support for 3.0.
> 
> Considering Arm lack of support and contributions for these PMD over the 
> last couple of years, the only long term solution I see to avoid PMD 
> code littered with ifdefs and supporting very old releases of the 
> library is to drop the Arm version altogether.

No.
The only solution is to work with Arm.



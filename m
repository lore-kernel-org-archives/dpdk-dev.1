Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CFCC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 14:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A35E8402B5;
	Mon, 29 Jun 2026 16:36:41 +0200 (CEST)
Received: from fhigh-b5-smtp.messagingengine.com
 (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
 by mails.dpdk.org (Postfix) with ESMTP id 707A840299
 for <dev@dpdk.org>; Mon, 29 Jun 2026 16:36:40 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DA0447A001F;
 Mon, 29 Jun 2026 10:36:38 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
 by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 10:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1782743798;
 x=1782830198; bh=MKjbzkWyDEZZIuRReJGOzkVqspFm9inmcRZhDTyXp78=; b=
 kE/WW88DaJxKharTjNu3Zp1eWLpov7nltshcYf0aEcAlyjACkJxcvvPTBxpUSkTn
 zjFIC0NS0O222lOQbTQTmufbQDVBArSrVFwLMrGj8O6Daqxf0AOE95QGZhErIlQg
 QhYWpzeH330GpqGKK8ZN5xiV8ExHGvv1vsr2v8rOId3waM7gHWoPfT3HNEi0FDnm
 ZPT1zt0GBt/ZD6DvGjEN+aMNQ5ve1tAs8QVpAxiDvfdB2ObBxhLOoCLmtDVNQWw0
 wih9F/IEtkAh4p8CBQOiI9AC50/iTrmwEdiaOKf1apKNOcE6t5swuFxHq9nxcYlQ
 J89yykPmFplREXy5uLYGBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782743798; x=
 1782830198; bh=MKjbzkWyDEZZIuRReJGOzkVqspFm9inmcRZhDTyXp78=; b=W
 c/Mo2YMaL/lqgXHKpyHhZhGQLAqeI46W0eSlFuGVkx/E0oL+wQP5Po6GiHfK4gnx
 4ygYxTxw+XS8WVVSUJR6ql9f10FkpcUwJcinL9xtrvKJutHxMGW0MK+oX14Qiz6L
 fYfTljB7LOaz7vkQrm2kpSScrReB07dabd85hLUAMC/aMHAbV+6uICDo+4A3AIY+
 AQ3bn6EAL4VtTUrrOTgzVizwRsaabuAj5oFhAEB43E5dMeUT6XnhZ/OpaZcWT4GK
 9pSlwxqveCRlqScxysbcCKZyyuVPj7eDKS+P6cnqbZzZ9lPZYRrcGiyZLOinCGSa
 LC2TSpn+fepe4kTqLAp2g==
X-ME-Sender: <xms:9oJCaoTlqs82eASC_CgNwGcNj0bD5SB_sTe3C0il9u1pc_dcGPAOXA>
 <xme:9oJCagklN9_brX_MU8wS6evUKpHt4ykHMd7rSw4ZGxn2ZpQFqIBlPF_37oA1jYntz
 Gy7EriENkeHhqXSKAEA9-qB8iv6afk6MOcthfHplscO2yOVlSi8lws>
X-ME-Proxy-Cause: dmFkZTF9/oybeDwLkeRU1F30cpaRbolSrakT4jPBi9Y9QfF1VRa9+GkxdDo7aNuH4rhPK+
 tl1cJw1DrfrcHBaD/1xhi1DkYvYfTZgIHJy3SJY8m9yFX/9X335lKDLoCXNT5msddzzDvK
 /quEQVPgLFNfwl0LFkNy+OIE4DN08p4hK5POzkn9iQzZ4gnIzz55rBS/fH8j9r1+4PUqPT
 3xBKb3Kh3CV/aJ/y11X5GIM2sIyAAF2YcSE8pgZzmjEXAxhQOwni2o9pvP/CpkZLrzw/u5
 tMg5KfEXYQAGuMyAtpqXXzRYH01Pef8P5eUnIMDTKhqYdJr8w3I8Ts6P943anqrvON1TFV
 UJLS7281fv6TDSUXymerw54sbz3mgCKC/HNcvSx6FRahhf0x+R4amPsRwYyZOP0jh01Unq
 /WAGXKkiD7Mwmt1HCeqjziI5lXjd2Yvuezyl9csHveCsOGV7pg4BPnqwjDXGKNssfmM5zo
 0wtiGJ1fnpI8xKlvrNQ8zee/urSxPj384OFlnIRYQO6eo2AzrDa3I02u6W/6VAqAJPW6BJ
 A1A/ldTs2MK1bwLPCdebmpUZTYw6i76sdsIWdNymQ/qxG3enUWADG8bYVf8qVxhcaD+ETx
 WOAXQVnntTMBiVC90M1l+k1tFCl2/mUfH8Z2yhvqu8Vq2H9jy/c2xQCmV+2g
X-ME-Proxy: <xmx:9oJCap2875U3C6bzbQw0QslDZfk3hHF8L9k3j4qfsZNjsZGCROpzkw>
 <xmx:9oJCanEdc6TFtJwxZSiVy8w2dC8szmQn3qTGk6m_KSNEpmGoInN_9w>
 <xmx:9oJCau4cjQHwUKzRZi7nbd8XeWPEbOVOp8cUOOuZVDfyr8cpiuBOcg>
 <xmx:9oJCalszm1nudixUDoHKVwB0TtORIh7aKQpayRDKiOgIf-Cj31RRSA>
 <xmx:9oJCapuVjpG2FT-3r6n_OTzT2nvECmbOFFiHkEuFqtylX9efvRoyXc_t>
Feedback-ID: i47234305:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 60683240009A; Mon, 29 Jun 2026 10:36:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 16:36:11 +0200
From: "Thomas Monjalon" <thomas@monjalon.net>
To: "gakhil@marvell.com" <gakhil@marvell.com>,
 "Emma Finn" <emma.finn@intel.com>, "Kai Ji" <kai.ji@intel.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Message-Id: <460428e2-1508-4712-8457-104a479df80e@app.fastmail.com>
In-Reply-To: <CO6PR18MB4484479022C9D2E2AEF13363D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
References: <20260619135330.1821985-1-emma.finn@intel.com>
 <20260622075651.1980461-1-emma.finn@intel.com>
 <CO6PR18MB4484479022C9D2E2AEF13363D8ED2@CO6PR18MB4484.namprd18.prod.outlook.com>
Subject: Re: [EXTERNAL] [v3] crypto/qat: require IPsec MB for HMAC precomputes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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

>> IPsec MB library (v1.4.0+) is now required for HMAC precomputes as
>> OpenSSL 3.0 removed SHA*_Transform APIs. OpenSSL remains optional
>> for DOCSIS BPI cipher fallback via EVP API.
>> 
>> On x86: IPsec MB required, OpenSSL optional (DOCSIS fallback)
>> On ARM: IPsec MB required, OpenSSL required (DOCSIS support)
>> 
>> Signed-off-by: Emma Finn <emma.finn@intel.com>
>> ---
>> v2:
>> * Fix resource leak in ossl_legacy_provider_load()
>> * Added release note
>> v3:
>> * Removed checks for openssl <= 3.0
>> ---
> Applied to dpdk-next-crypto

It does not compile on Arm:
drivers/crypto/qat/qat_sym_session.h:156:9: error: unknown type name 'IMB_MGR'

Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BEC606A332
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=REdXAa2H
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E97140E01;
	Thu,  5 Nov 2026 21:08:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 80DCA40DD5
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:08:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793909312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QcHU2Wijf+Hl0Ef2HEnabt2yOJJtllYwVUZMgTfMRc0=;
 b=REdXAa2HI2ZAvz6PGlHs2oCyHUZsNOIt0IoEKmJG0N8NAZcSJ+Q/WcZyAhPLOIQhXFcKqY
 /2Q+jO5X/LWOqjWhJoTZYH42mD5aeF/3/IbW87rZEgYboHliqvjE9FKeyT7BlrPymwfrmx
 2BlyGRQlPQuLADPey2mXgykgwLMRASA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-L8_CL-Z1MASVG0bjH866Qg-1; Thu, 05 Nov 2026 15:08:31 -0500
X-MC-Unique: L8_CL-Z1MASVG0bjH866Qg-1
X-Mimecast-MFC-AGG-ID: L8_CL-Z1MASVG0bjH866Qg_1793909310
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1e489f97fso30596095e9.0
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909310; x=1794514110;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QcHU2Wijf+Hl0Ef2HEnabt2yOJJtllYwVUZMgTfMRc0=;
 b=vUzKBF8Y0mnw6BfuOBgeNJJXVfvNEzUAxnfFwVpZWO1WC+CzeYRKnEDPtRYaGr4I6Z
 9D/nY36wA3QC5ryIgOcuIMJGZuQ+EJsOWffgt9Mm71IbGdv3R/7zskLQks+OQ9uiXBFN
 qD2JexI/3+9VWDNhXnMZlDYf7ikyEahlItg32cqkcDYjcrIzWbnQ6QJBWu+hTJrX8iHL
 E7AXyMc6x3yQ1aM1mURMH9ZiYNijhOqmNbi+q2445BSpYXe/kafRGEIJK5Kt0zskRYus
 Ak0rWVAVsVgRAc49/eAbymZO1nrd+TWB0duH6vpPmFzEct18tunI7JNR1Myptej7QWAM
 o1BA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw65GlMvLrYWg3EXC3+O7qfDSkLhKNWKq0/vbkmzE+n/SRj71eeMu/elvzJqc1G1s8Ib34=@dpdk.org
X-Gm-Message-State: APuU4Z+mSAXx3jeU4NEaLFo4A1OFk2Mgq2xXXJXCueHpui9Gs6CTj+G6
 FksmhdcpfwWXNqbO9NqwiUokcFg1anmwVAO1rpBwbGJ1NI4jUnAyFW4JXoQL640tB75TArBtH69
 Rx3R07447VUeRoZJTEhgdhNYMr05orAYNM4wsg88a/Kui
X-Gm-Gg: AYBFou0JyvXrKKvuNMtaSsyneln67nDjBNpqiKptkWisvzCIs9/Zor1sWvrq10G50l2
 NnkKua7ohoFmu3i/SfsxSbCOJJ6jdLi1fMtzCigUpHN8jcYzCk8nWnK52hfJAt0nmUsU8lWoq6c
 aMdz/dYmtKfWs4wvjEIUgpxhqw/SS7uWDOU6YC56WqsKigQaIxiQoL2diJx3c8z6bsF56UWfpc9
 u9xAmmTWS1nVIteQqR0qelHtN9iWiliNsyiudxfi7eity1cDDuOIwapRNyCH52EB6q0m6D4H0Xj
 48KT11LjxqMH3YENkHVTkK5TmryTmLjEft67YWTJ9lMQUhEq6NcVJDpTVBmm9160GTSCVxuQ+4u
 smgiwF4JQy9wP6tzRmaJhRLWmgDDLMbzOBVUg1EjEBeSA4je21qbg1iYwXdz520KkrYUMxABLVa
 IY79lb9zLxst2IplGvU8ZbdKQwLgD2gpARliXXBcqtxSXYjOwFKDXb8h6mxSedCfHzFYfKKcdTE
 fZRfQKkRXaYrB+Fzaqndp3kGR/PxFzHb2Xw4Cu6cvV2h2RpO6wVKPNa6AFUTobdZ8ITMiSNag==
X-Received: by 2002:a05:600c:6387:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4b6de1c6450mr3735315e9.19.1793909310088; 
 Thu, 05 Nov 2026 12:08:30 -0800 (PST)
X-Received: by 2002:a05:600c:6387:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4b6de1c6450mr3734985e9.19.1793909309664; 
 Thu, 05 Nov 2026 12:08:29 -0800 (PST)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d2bbsm12189270f8f.33.2026.11.05.12.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 12:08:28 -0800 (PST)
Message-ID: <2066bbb8-4ba2-4594-94d5-d2f7d09aae03@redhat.com>
Date: Thu, 5 Nov 2026 21:08:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] baseband/acc: fix PF2VF Bug for FFT window probing
To: Hernan Vargas <hernan.vargas@intel.com>, dev@dpdk.org,
 gakhil@marvell.com, trix@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com, stable@dpdk.org
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
 <20261103172902.4152956-4-hernan.vargas@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 xsFNBFOEQQIBEADjNLYZZqghYuWv1nlLisptPJp+TSxE/KuP7x47e1Gr5/oMDJ1OKNG8rlNg
 kLgBQUki3voWhUbMb69ybqdMUHOl21DGCj0BTU3lXwapYXOAnsh8q6RRM+deUpasyT+Jvf3a
 gU35dgZcomRh5HPmKMU4KfeA38cVUebsFec1HuJAWzOb/UdtQkYyZR4rbzw8SbsOemtMtwOx
 YdXodneQD7KuRU9IhJKiEfipwqk2pufm2VSGl570l5ANyWMA/XADNhcEXhpkZ1Iwj3TWO7XR
 uH4xfvPl8nBsLo/EbEI7fbuUULcAnHfowQslPUm6/yaGv6cT5160SPXT1t8U9QDO6aTSo59N
 jH519JS8oeKZB1n1eLDslCfBpIpWkW8ZElGkOGWAN0vmpLfdyiqBNNyS3eGAfMkJ6b1A24un
 /TKc6j2QxM0QK4yZGfAxDxtvDv9LFXec8ENJYsbiR6WHRHq7wXl/n8guyh5AuBNQ3LIK44x0
 KjGXP1FJkUhUuruGyZsMrDLBRHYi+hhDAgRjqHgoXi5XGETA1PAiNBNnQwMf5aubt+mE2Q5r
 qLNTgwSo2dpTU3+mJ3y3KlsIfoaxYI7XNsPRXGnZi4hbxmeb2NSXgdCXhX3nELUNYm4ArKBP
 LugOIT/zRwk0H0+RVwL2zHdMO1Tht1UOFGfOZpvuBF60jhMzbQARAQABzSxNYXhpbWUgQ29x
 dWVsaW4gPG1heGltZS5jb3F1ZWxpbkByZWRoYXQuY29tPsLBeAQTAQIAIgUCV3u/5QIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQyjiNKEaHD4ma2g/+P+Hg9WkONPaY1J4AR7Uf
 kBneosS4NO3CRy0x4WYmUSLYMLx1I3VH6SVjqZ6uBoYy6Fs6TbF6SHNc7QbB6Qjo3neqnQR1
 71Ua1MFvIob8vUEl3jAR/+oaE1UJKrxjWztpppQTukIk4oJOmXbL0nj3d8dA2QgHdTyttZ1H
 xzZJWWz6vqxCrUqHU7RSH9iWg9R2iuTzii4/vk1oi4Qz7y/q8ONOq6ffOy/t5xSZOMtZCspu
 Mll2Szzpc/trFO0pLH4LZZfz/nXh2uuUbk8qRIJBIjZH3ZQfACffgfNefLe2PxMqJZ8mFJXc
 RQO0ONZvwoOoHL6CcnFZp2i0P5ddduzwPdGsPq1bnIXnZqJSl3dUfh3xG5ArkliZ/++zGF1O
 wvpGvpIuOgLqjyCNNRoR7cP7y8F24gWE/HqJBXs1qzdj/5Hr68NVPV1Tu/l2D1KMOcL5sOrz
 2jLXauqDWn1Okk9hkXAP7+0Cmi6QwAPuBT3i6t2e8UdtMtCE4sLesWS/XohnSFFscZR6Vaf3
 gKdWiJ/fW64L6b9gjkWtHd4jAJBAIAx1JM6xcA1xMbAFsD8gA2oDBWogHGYcScY/4riDNKXi
 lw92d6IEHnSf6y7KJCKq8F+Jrj2BwRJiFKTJ6ChbOpyyR6nGTckzsLgday2KxBIyuh4w+hMq
 TGDSp2rmWGJjASrOwU0EVPSbkwEQAMkaNc084Qvql+XW+wcUIY+Dn9A2D1gMr2BVwdSfVDN7
 0ZYxo9PvSkzh6eQmnZNQtl8WSHl3VG3IEDQzsMQ2ftZn2sxjcCadexrQQv3Lu60Tgj7YVYRM
 H+fLYt9W5YuWduJ+FPLbjIKynBf6JCRMWr75QAOhhhaI0tsie3eDsKQBA0w7WCuPiZiheJaL
 4MDe9hcH4rM3ybnRW7K2dLszWNhHVoYSFlZGYh+MGpuODeQKDS035+4H2rEWgg+iaOwqD7bg
 CQXwTZ1kSrm8NxIRVD3MBtzp9SZdUHLfmBl/tLVwDSZvHZhhvJHC6Lj6VL4jPXF5K2+Nn/Su
 CQmEBisOmwnXZhhu8ulAZ7S2tcl94DCo60ReheDoPBU8PR2TLg8rS5f9w6mLYarvQWL7cDtT
 d2eX3Z6TggfNINr/RTFrrAd7NHl5h3OnlXj7PQ1f0kfufduOeCQddJN4gsQfxo/qvWVB7PaE
 1WTIggPmWS+Xxijk7xG6x9McTdmGhYaPZBpAxewK8ypl5+yubVsE9yOOhKMVo9DoVCjh5To5
 aph7CQWfQsV7cd9PfSJjI2lXI0dhEXhQ7lRCFpf3V3mD6CyrhpcJpV6XVGjxJvGUale7+IOp
 sQIbPKUHpB2F+ZUPWds9yyVxGwDxD8WLqKKy0WLIjkkSsOb9UBNzgRyzrEC9lgQ/ABEBAAHC
 wV8EGAECAAkFAlT0m5MCGwwACgkQyjiNKEaHD4nU8hAAtt0xFJAy0sOWqSmyxTc7FUcX+pbD
 KVyPlpl6urKKMk1XtVMUPuae/+UwvIt0urk1mXi6DnrAN50TmQqvdjcPTQ6uoZ8zjgGeASZg
 jj0/bJGhgUr9U7oG7Hh2F8vzpOqZrdd65MRkxmc7bWj1k81tOU2woR/Gy8xLzi0k0KUa8ueB
 iYOcZcIGTcs9CssVwQjYaXRoeT65LJnTxYZif2pfNxfINFzCGw42s3EtZFteczClKcVSJ1+L
 +QUY/J24x0/ocQX/M1PwtZbB4c/2Pg/t5FS+s6UB1Ce08xsJDcwyOPIH6O3tccZuriHgvqKP
 yKz/Ble76+NFlTK1mpUlfM7PVhD5XzrDUEHWRTeTJSvJ8TIPL4uyfzhjHhlkCU0mw7Pscyxn
 DE8G0UYMEaNgaZap8dcGMYH/96EfE5s/nTX0M6MXV0yots7U2BDb4soLCxLOJz4tAFDtNFtA
 wLBhXRSvWhdBJZiig/9CG3dXmKfi2H+wdUCSvEFHRpgo7GK8/Kh3vGhgKmnnxhl8ACBaGy9n
 fxjSxjSO6rj4/MeenmlJw1yebzkX8ZmaSi8BHe+n6jTGEFNrbiOdWpJgc5yHIZZnwXaW54QT
 UhhSjDL1rV2B4F28w30jYmlRmm2RdN7iCZfbyP3dvFQTzQ4ySquuPkIGcOOHrvZzxbRjzMx1
 Mwqu3GQ=
In-Reply-To: <20261103172902.4152956-4-hernan.vargas@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WSiwEMTz-91lpynkAv1bnEeW4PD29wO3X-KZhkzwosQ_1793909310
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/26 6:29 PM, Hernan Vargas wrote:
> Update of the PF2VF comms between bbdev and pf_bb_config to make sure
> all FFT windows can be read.
> So far only the first window was actually used and functional.
> No system impact. Affects VRB1 and VRB2.
>
> Fixes: 0d39ed91c161 ("baseband/acc: add FFT window width in VRB")
> Cc: stable@dpdk.org
>
> Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
> ---
>   drivers/baseband/acc/rte_vrb_pmd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime


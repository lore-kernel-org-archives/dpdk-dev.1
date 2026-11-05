Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6E606A326
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cBMh5w/a
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8054640E01;
	Thu,  5 Nov 2026 21:10:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id C4CB640DD5
 for <dev@dpdk.org>; Thu,  5 Nov 2026 21:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793909400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=spFE7u9uked1cgYFLak/ML9tmR2gLoruKWyGWePHczc=;
 b=cBMh5w/aXOi7HfUJjqewql4neUAei7V+kHHRw44ptjcFZ+pSNX64uYznk4F9SKRwiSUOjD
 GciYpqxOHdgDDCmEawc1yZ4XbZuOG8582F14H1fEJUMiv8vC5jHWspLkuhsW88j8JUQDYb
 pO6cfiqQPXu+s1b9scqLDVdEHBj9JHs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-sJ09IZSZMrCee0Fmkef2JA-1; Thu, 05 Nov 2026 15:09:58 -0500
X-MC-Unique: sJ09IZSZMrCee0Fmkef2JA-1
X-Mimecast-MFC-AGG-ID: sJ09IZSZMrCee0Fmkef2JA_1793909398
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a35db2d6b3so17814115e9.3
 for <dev@dpdk.org>; Thu, 05 Nov 2026 12:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909397; x=1794514197;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=spFE7u9uked1cgYFLak/ML9tmR2gLoruKWyGWePHczc=;
 b=DbVf9N5DZ96UG60QwTljiq/Y9DsOvLqQouFAX34iP2HwWN4DW2wiVULEO8H9CSK6fU
 aNZ/KmAVHYG886InAKu2m7hKpNykWYcOaOq6/LN2R2Z3XyxojaNr5CQUAy/i6zz7CNkK
 pkZdL21UJcaeMpc60IRd86SqunfJKYWyyI2/7g/Kt5UPQBlncGhx7TsLMQvweIZDAsPz
 pCTCI6gS93b8gPU6P8WzKxmrTZPEIbudXWDeaMNGnuSxYf1KfUMZTFrfyk3AAVAsr942
 JM/il2S0bEDWloK5oS38sr/7cFm2BnBLdZ5xC1vyjI3NK1LMYh/pGJFUDsDJfcKlROrf
 kw0w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzl+cgFrH7KXLTuiJbOGUf7OXd2kbMFq8LP+4xfafvEY2pxFFqfpFSuqo8nm0Ew/LaMb1Q=@dpdk.org
X-Gm-Message-State: APuU4Z8B/Xil+QCT8wP3tVSmY3If+qed/QJEG3ySV2GjxGRrGnFvual6
 v/kh4Jwxhx6XvRzvwvEVhPVSoebMIfeKyylKLhnynh7EZA6NbxOFStOMtEp4o3znQ6WPRNIrQt+
 6bDN1RgTwC4ChpBbVM9xtHgnwOKw2nZVoKMgdV5qJ5/kZ
X-Gm-Gg: AYBFou3UBwbsvCx79ekrf1Rgw+2fSRBuB4s5MgnHbyCmQJDMQPhz5RIASTKW9g8iiqy
 SW/NrloPy5ZuLUDl3SEOwhVkiSBjqsPokvZZ1kW3B4MTBqDYTZ6f33lsMU1cw/mHpXArldCMsrj
 KZiNgbiY9wTKPccqMHwcbY1BV3mGgWWNprUxSY6CUOjkN8KHUtSVoLwUnwVYGsfHulo/gnvBmY5
 jNLPMdG2e5UyJ7w1hgOXr75H1Dq9Q1FsQFJuAdVAHDJtFZYiCYNrN+nMZOW/nt7FePr0UAoDo1D
 aW2LuT8wmZZKyeKxB6QCvpjsgVZ8MXbqlenuYCXQNIYdXcjY8ZeQUUuyZQYbr2MOOVqL1O0Xqx0
 IO1HXfulr7b7fkuwf8O+7vZNMJXXbETJ6RUCDrzxYrt+tOq0AQ4xH98JbhR2batTeOjbhI+F04b
 GVSjS9gqByLas1ow20pY4aXZRrA77kJ6uFQw7t3tV+m4Sr5sbJvwaCysvXGh1Lm6xsU1p/0TP6D
 O9kmRF84BNdphnmYgTbInfpuKCo0OQ0GCKWNNu+8OxjE/iO+g4Z51aTemOF8w+L6hWV+ZeVWg==
X-Received: by 2002:a05:600c:c8a:b0:4a1:f7f4:7cf2 with SMTP id
 5b1f17b1804b1-4b6df6df796mr3363015e9.17.1793909397562; 
 Thu, 05 Nov 2026 12:09:57 -0800 (PST)
X-Received: by 2002:a05:600c:c8a:b0:4a1:f7f4:7cf2 with SMTP id
 5b1f17b1804b1-4b6df6df796mr3362675e9.17.1793909397069; 
 Thu, 05 Nov 2026 12:09:57 -0800 (PST)
Received: from [10.50.0.132] (82-66-145-51.subs.proxad.net. [82.66.145.51])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm162325185e9.4.2026.11.05.12.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 12:09:56 -0800 (PST)
Message-ID: <1e32b4a5-8967-4e11-8b6f-bf600fafac19@redhat.com>
Date: Thu, 5 Nov 2026 21:09:55 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] baseband/acc: fix ring interrupt handler err path
To: Hernan Vargas <hernan.vargas@intel.com>, dev@dpdk.org,
 gakhil@marvell.com, trix@redhat.com
Cc: nicolas.chautru@intel.com, qi.z.zhang@intel.com, stable@dpdk.org
References: <20261103172902.4152956-1-hernan.vargas@intel.com>
 <20261103172902.4152956-5-hernan.vargas@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20261103172902.4152956-5-hernan.vargas@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: asLRHiFLZj7AQoCsnqXpJmQeLS7OIFqQRZJd7AejN00_1793909398
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
> When get_queue_id_from_ring_info() fails to match a queue index
> (returning UINT16_MAX), an early return skipped clearing the ring
> entry and advancing the head pointer. This left the valid bit set,
> causing the same malformed entry to be reprocessed on every
> subsequent interrupt, blocking all further ring processing.
>
> Replace the return with break so the entry is consumed and the
> loop continues normally. Fix applies to both PF and VF paths.
>
> Fixes: 3cabc8eaf524 ("baseband/acc200: support interrupt")
> Cc: stable@dpdk.org
>
> Signed-off-by: Hernan Vargas <hernan.vargas@intel.com>
> ---
>   drivers/baseband/acc/rte_vrb_pmd.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
>

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EC4EF36FC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 07:52:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B99B402DC;
	Mon,  9 Mar 2026 08:52:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 805F640281
 for <dev@dpdk.org>; Mon,  9 Mar 2026 08:52:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773042754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upgNP/k3Len6Y+vZ2qapNCHlCFG1qCMSEqyEtM9xuWY=;
 b=YkztzivJsH5NDa3hZT+P4cS9Hx/eZFQcZBvWWfPcRvog/tyjxqWAGMmX6xC3EuoGL1RbxX
 TkSiRdwbKDzb689CrRH96DWIkt5gaB5ciOQ2+6tMAJBSwBXMY0asMms2QK8oO6dpPt1C1A
 aJ6X3HmE41McAG8/hnY1mJFPNgguNV4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-1hHa5tmPMfmDmw0ZkTdZSQ-1; Mon, 09 Mar 2026 03:52:33 -0400
X-MC-Unique: 1hHa5tmPMfmDmw0ZkTdZSQ-1
X-Mimecast-MFC-AGG-ID: 1hHa5tmPMfmDmw0ZkTdZSQ_1773042752
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-485390246c8so9019975e9.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 00:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773042752; x=1773647552;
 h=in-reply-to:references:user-agent:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=upgNP/k3Len6Y+vZ2qapNCHlCFG1qCMSEqyEtM9xuWY=;
 b=l3xZ7PA6fLPtwIcRcJYGwel5CyzzJhWdvNc7xXtWkmYEpMk9kjsRm1DSvK6BW//s2p
 YbLJ6kUhQ7+Nc2/fZwIRDLHlRYIlA+BCc1+tCxCcQKQzqqRg9ukQRxU3GJgn2YbLo2sT
 mliHI1L2HPRF5LNufmhNhJ7uRaYtTH9ZBffcblhvrbluWAdVOx7F4ycUqU3szWiBTrn+
 Lyw3qzFZIT/v2tr/EdGBOaxq22CpikdGoUC+4W5lmO3SpiEyFRFRHHrd9aArNFGZmNCK
 DzP8rKqzebl1eU/rvUWqdl2BgUI3NBKtVI9Ye8nZkp2B7uWUpm6NVXiD1cm1Y+0TCYM+
 R3Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf5TiM5FdWjKtt1vwC0dfdenaMcldJXhlMauQj2iL9fTL5SHBFpTqD3Je9Rn6dr0SQ8aE=@dpdk.org
X-Gm-Message-State: AOJu0Yzpwo4oU0KvhqQJfvY24pESoOsvfDena7q0qnx+4yjqoKnYQVkX
 c/Y3/phgaTRtR0gsUkt1Q+RTnr9nJJdTYgvFIijrvp1GIaWY0fnsTVESqAM4qXe3KnrN8EYmtsD
 OL8EYe95LvOvFwN/T6Zspryzbz36rohenWrYN8EUJADAIQuTgwARI
X-Gm-Gg: ATEYQzzYIdKkKvi2Ajyn3BqkURUtdLE++JBNpVS2WIJDiAfDjAmAa4vYo8avjZFSnLA
 BwwrGUcVTsmisKiitHdHFlMeyjSdZHTElN32mODFtePlD0wz1+Od+Jb0tBLvSxT9Bv4mdL1aHUi
 yPVnvs6jM62SddDvX2LiptIP6qOI7WUx0hc3lSBYUZHuPGMJ8mArjJTk82eS0+60jlz9rAjUk1v
 xg2ADBBEn/2BbCN6tDnxN8bym/IqJbzHLtBLx/C0XHp42tDJcgS2iiouxKiL5bnNRRsE45rMsy6
 5E5BLH7R8XRIKZlkWh2Ogp83qWjktMur2o16DZB3tYirx6/8sy70Tnyu8Ns0T0n1/cypm7nYo8h
 E9P9NOJz22H20FA7oQ3klE7EdIMAw6vdXEZtzCAK4zdCIFDZeGHCRuXulRA5eq/1T0z4FLlsNoj
 Dfhlm5
X-Received: by 2002:a05:600c:450c:b0:485:358b:e80b with SMTP id
 5b1f17b1804b1-485358beb14mr63151965e9.0.1773042751956; 
 Mon, 09 Mar 2026 00:52:31 -0700 (PDT)
X-Received: by 2002:a05:600c:450c:b0:485:358b:e80b with SMTP id
 5b1f17b1804b1-485358beb14mr63151755e9.0.1773042751466; 
 Mon, 09 Mar 2026 00:52:31 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3c80esm21756510f8f.29.2026.03.09.00.52.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 00:52:31 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 09 Mar 2026 08:52:30 +0100
Message-Id: <DGY376Y34LNU.J0HOHBT3S7AM@redhat.com>
Subject: Re: [PATCH dpdk v3 0/2] hash: safe data replacement on overwrite
From: "Robin Jarry" <rjarry@redhat.com>
To: "Konstantin Ananyev" <konstantin.ananyev@huawei.com>, "dev@dpdk.org"
 <dev@dpdk.org>
User-Agent: aerc/0.21.0-127-g39acbf663345
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260306084710.492520-4-rjarry@redhat.com>
 <540b570f12bb458997f4b8a1a4322dff@huawei.com>
In-Reply-To: <540b570f12bb458997f4b8a1a4322dff@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Af8AXM-yNF5aQl-bvm6Jeas7JnQhYs9fgd0im1B0Zbc_1773042752
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Konstantin Ananyev, Mar 09, 2026 at 08:50:
>> * Removed the rte_hash_replace_key_data() API=20
>
> That's a pity - I think it is a useful one.
>
>> which required to bubble
>>   a potential old_data pointer from search_and_update() to all
>>   intermediate callers down to __rte_hash_add_key_with_hash(). It made
>>   an already complex code even more obscure.

I can send it back but it will make the code complex since I cannot free
the pointer in the callers. I need to pass it down the call chain to
make the free-or-return-old-data decision.

Let me know what you prefer.


Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B519606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/U8HOib
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656D04028F;
	Wed,  4 Nov 2026 11:31:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id 9992840151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 11:31:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793788288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1E7bMmBaR7eLJpYB0gW78EJAkiV0F4AJaTM6uHVvK4=;
 b=N/U8HOibL2UdjpresJyZUUcmQcJjfl2iXpdRgGquiH+lixFeWv923rZkxTKdCALUi/HYQG
 wFck0UNJiB1pHlrAOggeYA2umpNedYdfRIvixpRj2SSJfz2leO/csWt/akzx1UFweTmgn4
 edTeK4udrQk59Jv9Hb8uZdLSKb6aa/A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-RHTHm72WPjOlOGnZta7rYQ-1; Wed, 04 Nov 2026 05:31:25 -0500
X-MC-Unique: RHTHm72WPjOlOGnZta7rYQ-1
X-Mimecast-MFC-AGG-ID: RHTHm72WPjOlOGnZta7rYQ_1793788284
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4901562b819so482064f8f.3
 for <dev@dpdk.org>; Wed, 04 Nov 2026 02:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793788284; x=1794393084;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j1E7bMmBaR7eLJpYB0gW78EJAkiV0F4AJaTM6uHVvK4=;
 b=iTxFckaGhdQlK5P3Pf6ej6PCvi04238GfebG3sJ6wQEWpMavnDOSH+TeK5cjnJqkiF
 Fe5pmB+jqcwi4FfGQtahtKD8TaDb7jEowDXn/K0uOdhVB1JrX7BMTCyDIJnT1zCqoEqA
 BSe0C5w1zGwUSSmc8CuaMXXBqyURi3f7/4tC0mr3/sjwQrtobc0DJgV8+kAovlDxGNPq
 gY/B4BK6Wcw+NBFsw2zy+HHl8zi/FsSRIOL1KSelCRBBYC1Otr2ee/V+0n7k64FS9o9u
 +RAOWMvkBn0dMFsxYZFt2M0JIv6dKvRxImJWLzRmUVGv22ZrmFgB1JAvsWen/IRvreb0
 SdAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7w4F8Ez4ynv9U0zla3mT+NI3XsGuBpuspbjpB8N21AdE+Uxe+xheoFLT+q0KElcnIXq4=@dpdk.org
X-Gm-Message-State: APuU4Z9wIoHw8T0HQ+3uH7njcjuhRa3EZAXdh+nXlI5vYPkryBpa8+xB
 99IadFabBQBv2wpw+Y9aFgNMPBz4HyP2BDngeFMKilLo+StVol6vECIOMVkXc0dTlei8mv88LBa
 hZh+DJ9JAsW7RxVfsJUAKSZ1h5pdqOssahJhUsIbMHlE0
X-Gm-Gg: AYBFou3qAu7HJCHHhWiUo26w/HKewF8ENhAK2WN5Zpnb0oIKO+j03EWV1RYpcl8pfqS
 YlgkWPLZoaRznAZTufVQ5SqQ3UmYqMGp4anqbWfbc4yjaJDA+fVmEUiBfrdvW4yAGbX5iMHGn+8
 RWwxdR2BwfWJ31DDZ5ERciZKvwBb4GvKPK5cRj75NSGaIczSONl3MmQZBm96dVrH0jJEb92VoYe
 stN6n6B7xUbk8obkj5vRvZ/8hMRPjtIECQAiIXfgTaBUSm/16r4F2LmU/dJClAuqfDYTVjIz0Q2
 AqWHJLlBJB7wEg5czkHucwUm7rip0U4LrDd1fo4C/fQYRx4xVK8h5NuBHWyaojQUN31kw19T2Bs
 4roVs419XFg6InVvHe/P2FQr1cJHzrxIC/El9WXm1qgp+mJvg71EXC70s1sdKV6vwfLudsPP0/D
 O7Uq+AVM/lDaAjkeB7bWnlG3BazvGmTAg=
X-Received: by 2002:a05:6000:4212:b0:48e:60ed:b012 with SMTP id
 ffacd0b85a97d-48e6e4f69c7mr36056118f8f.57.1793788284292; 
 Wed, 04 Nov 2026 02:31:24 -0800 (PST)
X-Received: by 2002:a05:6000:4212:b0:48e:60ed:b012 with SMTP id
 ffacd0b85a97d-48e6e4f69c7mr36056084f8f.57.1793788283814; 
 Wed, 04 Nov 2026 02:31:23 -0800 (PST)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec8d8748sm3121260f8f.16.2026.11.04.02.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 02:31:23 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Date: Wed, 04 Nov 2026 11:31:22 +0100
Message-Id: <DMMCVKXKF47Q.3IQ4WAJ5COPQQ@redhat.com>
Cc: <stephen@networkplumber.org>, <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "David Marchand" <david.marchand@redhat.com>, <dev@dpdk.org>
Subject: Re: [PATCH 1/2] net/tap: fix FD leak on netns change
User-Agent: aerc/0.22.0-38-gda2e3af216c4
References: <20261103171730.1361878-1-david.marchand@redhat.com>
In-Reply-To: <20261103171730.1361878-1-david.marchand@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gDtki5MLEkGXy_JQP_Pk1pJTw3tUdbn128F6zt6ecaw_1793788284
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=flowed
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

David Marchand, Nov 03, 2026 at 18:17:
> When a tap interface moves to another namespace, tap_netns_change()
> calls tap_lsc_intr_handle_set(dev, 1) to recreate the LSC interrupt
> without first tearing down the old one. The previous LSC netlink
> socket fd is never closed.
>
> Defer the full LSC teardown and re-registration to an alarm callback
> which runs in the interrupt thread but outside any active source
> context. The alarm switches to the device's network namespace, tears
> down the old LSC handle, sets up a new one (opening a fresh netlink
> socket in the correct namespace), restores the original namespace,
> and forces carrier state back up.
>
> Extract tap_dev_ns_switch/tap_dev_ns_restore helpers to share the
> namespace switch logic between tap_netns_change and the alarm.
>
> Fixes: aae3a38e9e03 ("net/tap: detect namespace change")
> Cc: stable@dpdk.org
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> ---

Reviewed-by: Robin Jarry <rjarry@redhat.com>
Tested-by: Robin Jarry <rjarry@redhat.com>


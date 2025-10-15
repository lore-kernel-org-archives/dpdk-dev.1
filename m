Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72590CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:32:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACC2B40B95;
	Wed, 15 Oct 2025 11:32:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1D3A340B95
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:32:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760520759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oQ7rL+uzADT2E0IW9U4Wc+sP9sN69DpUVymHg7D7r4I=;
 b=XxJFf4sURKpHXQTl0jJIH6m2OgrWB7Z5oYUUlCasYuI3JsRR3DiPMSzPqPbTvyBMAAVTx+
 +OEzi0kEovo08ANfV8NFIAr6LzXp6Zvz0D11/8ZgJ8e6buW/Hwz0qG8oOYizTLj+6QOqKM
 DkVSAuBakoKXz+3UlGBLUBe723YUSOw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-Gywbs4VMONKY6GD2VypsQA-1; Wed, 15 Oct 2025 05:32:38 -0400
X-MC-Unique: Gywbs4VMONKY6GD2VypsQA-1
X-Mimecast-MFC-AGG-ID: Gywbs4VMONKY6GD2VypsQA_1760520757
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso314727f8f.0
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760520757; x=1761125557;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oQ7rL+uzADT2E0IW9U4Wc+sP9sN69DpUVymHg7D7r4I=;
 b=t8RoOQomZSOTphVzeZjOfHwz+znQ4JPRSGuZLbxPDvdswOyHNPR/Atb+bzw7v/7NLe
 NIFB+deu3PB0bMl4gwJz59w9lr8C+KtECoZdWv1RtBKQDpWltn4ZEeSFK6coDDgiYsk9
 etGdn26eNc6Y96mSYxTn+QcXIAPA+5UbxA84bG62s6UQz4aYK2C9pf+xACUwEFxPIXMc
 7l3S5/CMDN0H29cmvkd4+d6/NQ2Xpoc8MBAe9yDnLCHC5JDLOG0QxVYNRn+Pf1Up0cK5
 ndB01anID8KZBSwzV6LdKpXa7Mwp11MtLUO9YvP28z979Cg1zZUdv/1Rj5osi4b7xHWc
 OnYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7o8G77EEaiSCfPqhWhYTSWkR1ovL4+t/cjMpE5zEnPbSWnIRg7CDJMpkvnnR4ipY4Nz4=@dpdk.org
X-Gm-Message-State: AOJu0YxTD769rAQ+ryB2JDm0P4Ss0EARPO0Vj0iJuGinvC8AmK4T9BNo
 eQ3VHE5ly7XaCwcRIzuG1zQxg+t9mOCYYbjKFNnZcrfrMDhdvOQh/mjRd+4IwrtkuRJtrnGkXss
 FQkiSi/g/PeQ37YKdNvwPnW2/A8JKcQvWtEeNUE/bEz7e/TjftDs/
X-Gm-Gg: ASbGncthvLBGF9GwtdlTnVoFmKq4OxYGrinlhTbusWdTeNkDMcKTD0ktyNq7vA7YtLL
 JMAsHcOUK4myfi1nMsyMFcxMa8N885TqMvFOCPCgfLB5vzu5egyptGzlPHGxV2Pj33oVaMkwPKS
 SP43M8mTySv4Zz+Khfsoq/bDqlDd/SAuIwr9rRwiHwqIs0cB3NdPQyuVWGamT3kGS1dKgt5s/28
 32O0QG5bK6JShiknAonhtxWmYpjqal80exqDcePw0sexRVDrOyzSXWayClDExkajSkE/lnxaIJ/
 P/5A8JiYjtldqpB+tgBDRnaR4wl688afjwHV9YSXkEDpvpBK7ppWQGf4rRoShGZVHbeziZDch9l
 uyD/iJdzdleCPjrmsNdRPlA==
X-Received: by 2002:a05:6000:2dc7:b0:3fa:ebaf:4c53 with SMTP id
 ffacd0b85a97d-42582a055f0mr21923434f8f.29.1760520756957; 
 Wed, 15 Oct 2025 02:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGorlDkSK5cyTzBH2vSiJpheWLf89uMWNQeest1KO4py/HhF2ySgrWxowajenUmqXtz5GGWPQ==
X-Received: by 2002:a05:6000:2dc7:b0:3fa:ebaf:4c53 with SMTP id
 ffacd0b85a97d-42582a055f0mr21923418f8f.29.1760520756535; 
 Wed, 15 Oct 2025 02:32:36 -0700 (PDT)
Received: from localhost (2a01cb00021ec0002e23edbec21b0e73.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:2e23:edbe:c21b:e73])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b99fsm292329035e9.3.2025.10.15.02.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:32:35 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 15 Oct 2025 11:32:35 +0200
Message-Id: <DDISITO3VISA.3ER8HBDM4WX4Y@redhat.com>
Subject: Re: [PATCH 2/2] fib6: fix tbl8 allocation check logic
Cc: <stable@dpdk.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>, <dev@dpdk.org>
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20251014181755.114300-1-vladimir.medvedkin@intel.com>
 <20251014181755.114300-2-vladimir.medvedkin@intel.com>
In-Reply-To: <20251014181755.114300-2-vladimir.medvedkin@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1ALJtOFN6z0w6EwKA38tjRWKxoPGpm3OB0Fntc8oDzc_1760520757
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

Vladimir Medvedkin, Oct 14, 2025 at 20:17:
> Currently if there were 'n' preallocated tbl8 entries only 'n - 1' were
> able to be used. Fix the logic allowing to use all preallocated tbl8
> entries.
>
> Fixes: c3e12e0f0354 ("fib: add dataplane algorithm for IPv6")
> Cc: stable@dpdk.org
>
> Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
> ---

Tested-by: Robin Jarry <rjarry@redhat.com>

--=20
Robin

> This is not an offer to sell securities.


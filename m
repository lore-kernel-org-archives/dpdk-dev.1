Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0704710BA430
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 07:43:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 295E3427E8;
	Fri, 27 Mar 2026 08:43:37 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 12993402C5
 for <dev@dpdk.org>; Fri, 27 Mar 2026 08:43:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774597414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8UuNaQvW19FAOTzMOQwJ6sL3jNDCRNiFO7vZg0+uS8o=;
 b=R4z+5uMJxiV0GzKcV5VPhbuIVgy2rM9gu/X8rdqljEMFCirVQcDY/+Lce0x64M9DdJDHj6
 ezeXxNTfv/ZxWSOVnZIyhdwDgcH79f4lnmBoaub18+o9bExVWqY/MXxWIHoPVnITmcZL1y
 otPOiZMzAVw5qc/q+PTS/a+H7hUrn3c=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-BWiU4tXpMWCWgcRcg8_emA-1; Fri, 27 Mar 2026 03:43:32 -0400
X-MC-Unique: BWiU4tXpMWCWgcRcg8_emA-1
X-Mimecast-MFC-AGG-ID: BWiU4tXpMWCWgcRcg8_emA_1774597411
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-38bdaeafc4aso8317521fa.1
 for <dev@dpdk.org>; Fri, 27 Mar 2026 00:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774597411; x=1775202211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UuNaQvW19FAOTzMOQwJ6sL3jNDCRNiFO7vZg0+uS8o=;
 b=fJApfE3PA60R6N1rz5KXnZqOH0G19o6XU2lk9gVsDJerTMkf3zDMA3HMwlseTspnho
 3gfKgIoYnJgO1go/nP0qoSsMaZN0gqNJoyxucYMxOhSFbtKRtMT0Sdk8dfEZMQHX3p5t
 odU4X8cBA4nX/jN6BJ9L1+pl9Bu92rjDplyKecuSmdDNyhnq4w/16GQmPj+Vxpc/LlNv
 NIq5RpDhZkIN9UNMx6wZA3Vy+D+y70+1cOewUSq3fAE2G7tgU+MGS6f3x5T3IZDEAplL
 QFIjtw+jWnXWRtWhkIDDgLYyc3lxq/dximZAJX8IevstwiJe+7WnhgwVHXFKzi9IKcvu
 hvRg==
X-Gm-Message-State: AOJu0YyLX8JxpZOvYi3LnlWhhkWngo5XF+p6mk7puTnG/L9OwE4yZVIQ
 zjNlWX2zdP02Gqb+IMsCczjhQGx8BhDVx6LCmSdP35amJ2mpT2TVrXb0UDaxWk03QRLj3MaE0dM
 bQglz7tGLqVVrdwzZOTFYVkuNAcTD6r8VpruZxVP6Hnp7NQNk3Z7kuc+EHzzQWzjoQg6jr1IFNJ
 P944dUQRCmQ6ZYksWHXXI=
X-Gm-Gg: ATEYQzzgroZrMEVG4c/ZpWFV5GYQpwe9thSpDT5OJqDBrEB1hJIiQ4eoIleSUH83ofq
 bkOmalFjzBwDOlCxuqjrnwBtaIUeIsc6xiB0uKPkVRAqKvK5fq3NtQH6CqqOieP1oCKNuJ0E1Hd
 zq5bCoN3iCfXQ907y7qT/RXuvmSPAVLHiReSj1oLLcqy12RFllN+9JO2H0waN14BUctU7UfmA57
 1feZ2mAYjbKRVOj5Iy4Y7bFbJOkRNFVKHIGAj70mTJJZ7TXCy5WKbbptopHUDLYqj6/kg==
X-Received: by 2002:a05:651c:1b05:b0:37b:a30e:fe1e with SMTP id
 38308e7fff4ca-38c732638b9mr6201391fa.18.1774597410805; 
 Fri, 27 Mar 2026 00:43:30 -0700 (PDT)
X-Received: by 2002:a05:651c:1b05:b0:37b:a30e:fe1e with SMTP id
 38308e7fff4ca-38c732638b9mr6201201fa.18.1774597410295; Fri, 27 Mar 2026
 00:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260327041517.812223-1-ajp@marvell.com>
In-Reply-To: <20260327041517.812223-1-ajp@marvell.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 27 Mar 2026 08:43:18 +0100
X-Gm-Features: AQROBzAKHttSsAuZp_pQ_QQf34CxcsnSXDytiYDdkf_uzh1i42nlIO4_A67FRxo
Message-ID: <CAJFAV8zO5T=q3CD8+jLyvCM+7HQrxMciJ3Yz+ubUp7iSdbr-kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] examples/packet_ordering: fix format specifier for
 port ID
To: Aarnav JP <ajp@marvell.com>
Cc: dev@dpdk.org, Volodymyr Fialko <vfialko@marvell.com>, 
 Sergio Gonzalez Monroy <sergio.gonzalez.monroy@intel.com>,
 Reshma Pattan <reshma.pattan@intel.com>, 
 Declan Doherty <declan.doherty@intel.com>, Neil Horman <nhorman@tuxdriver.com>,
 jerinj@marvell.com, 
 ndabilpuram@marvell.com, rbhansali@marvell.com, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: caLYLPTiEH6utYdKC5kNmNEcNwAfqEwCksxieYo0Sic_1774597411
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hello,

On Fri, 27 Mar 2026 at 05:16, Aarnav JP <ajp@marvell.com> wrote:
>
> port_id is uint16_t, use PRIu16 instead of PRIu8 to fix
> format specifier mismatch warning with GCC 15.
>
> ../examples/packet_ordering/main.c: In function 'main':
> ../examples/packet_ordering/main.c:740:46:
> warning: format '%hhu' expects argument of type 'unsigned char',
> but argument 3 has type 'uint16_t' [-Wformat=]
>   740 |   rte_exit(EXIT_FAILURE, "Cannot initialize port %"PRIu8"\n",
>       |                                                     ^
>
> Fixes: 850f3733f840 ("examples/packet_ordering: new sample app")

At the time this code was introduced, port_id was a uint8_t.

This can be fixed when applying:
Fixes: f8244c6399d9 ("ethdev: increase port id range")


> Cc: stable@dpdk.org
>
> Signed-off-by: Aarnav JP <ajp@marvell.com>

Reviewed-by: David Marchand <david.marchand@redhat.com>

-- 
David Marchand


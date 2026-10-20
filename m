Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C471606A31F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=t+UezF7B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E25140283;
	Tue, 20 Oct 2026 17:09:02 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 061894025A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 17:09:01 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-ccca948203aso1265540a12.3
 for <dev@dpdk.org>; Tue, 20 Oct 2026 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792508940;
 x=1793113740; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EbJnLLCFh+eLP/02RE6Yct/O9pJ2Zr4Yl+q6FPQpbDI=;
 b=t+UezF7BIVhBX5WPrf8ixi13/NMt+Y1TNxQmbz5osDjqn6i8wLJ+f3g5COe4ri3Fcg
 T8H7smJZ5uB6cwJo/FOTHTZfXz0X4GUczaSbK1/1mOCxCYpAj4s601iOr0nawpNh0nXu
 CLnMd9Q7oOZ676WRbcbFd70Givpe7yvgrLKpV+71Tj/tMCQyRzSY/Y0XrmucwEyX/l7w
 zOPBCKW/YzCWqfbhNL2Cdl8ydG+/jbqnKYTGKuxeRPG4VkxeFXEWD4a147Jecy9N/RwT
 bWpWlqnxj7CzjiFbiBq9RvfM5M+lVw3+Vv2OThGESQ62UuFjV6ztbehwfTlpSMIvcpaz
 rJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508940; x=1793113740;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EbJnLLCFh+eLP/02RE6Yct/O9pJ2Zr4Yl+q6FPQpbDI=;
 b=OUxYgW4jK+i2nHlmfADvHD+9HgA/wBV2H1CAvVHfRQLQmM8KcdgaFRcKjcBAspfv2M
 h46BWutwkxAlDjuSVHplu4BNduHlkNQxLfyTJ7zdqsc1+03E+oVySl6maslocZd413za
 COgpHSXdwWlAglP9yQGcnxG8jNFoBIwR6Hf9uEqWbzK0AI3m4Yne/MYtUmz4JoNqumd0
 3mybZxmBchLxLoRHLlfYOLG6ZnbB7lgt8nQyxftQYBgszOXEFqPrjTH1u+X44f6e7LlJ
 56DdGqU8jx4W66vhIpaN03W9Z32lH0r7S6Qsv/s7PioQwBDN1NIHL3vbXuGMI1TVrDW8
 Wyfg==
X-Gm-Message-State: AFq9FYIArn25tHqsB7z39Q59fbjk9x4OMRYdiG1rnJhPvpDq+7MNRgUA
 Dfmn1uqV5hIE5Qpmyi1I1OWKNQNE+IT50dknNUa8dpOHJCe4yu3jOFzrxcAicerIOlM=
X-Gm-Gg: AYBFou0emHFBjflRMb9MWqr1UTKTg2Sxze4AbeOCY95C+ro/qdBjVS6+9nPY5pgR44/
 7PIGb458IbsvSZ8JMBrpIytmwZv2lb7CjpTszdRVuF9GTMmu/muj8tmzOkE+wxtAfnf/zjrVwbI
 bTA3CBDMokELtbP6uK3kii2//dGal8MhWRfXIfLkZu6kV1i0B9U6YF5fzxb+uqYx1sduVRQanZB
 oJjH1ly10Wd7v6ALlfUEikvM01V+CI7/EHcHcu/Q8Y3/CUgz77b8gCoZKlCYrDAd5kudSzYFlp9
 zxiOU+4xaCAOVr3ST8aC+H/HDBbnIBFE1hCRx7TJB3pJbRnDFInBlQw8cIFAK0rEWHnA88xSag2
 0f5TELLcgEZvRtr5gmj8uAyRQQ4UQXqcWCnwtmYJ/JJA5NT5kfjDMIDaDqYMSOaLLTaChLkIiiK
 5QO01TRop52Lei9MJXuRP2zo6Tev6h7HFI0wxOOZixZ85Os6XhM+G29eUKtpzUcCShr9U9DlbeP
 rUYr/rPt4E1lM4po3if+O/+UFhUdns6RtLEi6P3Gunl0BP9XxIdvMS6WdoRGktSqUiORvgzH0p+
 Xp+6SRuy6hIVcrCPwJeQtw==
X-Received: by 2002:a05:6300:6cc5:20b0:3e2:3392:5408 with SMTP id
 adf61e73a8af0-3e233928588mr4783578637.79.1792508939943; 
 Tue, 20 Oct 2026 08:08:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd65497dfc8sm5000252a12.9.2026.10.20.08.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 08:08:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:08:58 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ryan Wolfe <rnwolfe@google.com>
Cc: dev@dpdk.org, joshwash@google.com, stable@dpdk.org
Subject: Re: [PATCH v2 0/2] net/gve: Rx scatter for GQI
Message-ID: <20261020080858.29d7e086@phoenix.local>
In-Reply-To: <cover.1792439728.git.rnwolfe@google.com>
References: <20261019022824.189319-1-rnwolfe@google.com>
 <cover.1792439728.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 16:20:02 -0400
Ryan Wolfe <rnwolfe@google.com> wrote:

> GQI receives a frame larger than one Rx buffer as a chain of mbufs, but
> the driver doesn't report RTE_ETH_RX_OFFLOAD_SCATTER, and it chains
> whether or not the application enabled it. 1/2 reports SCATTER for GQI
> so an application that gates multi-segment receive on the capability,
> such as VPP, can turn it on. 2/2 refuses an Rx queue setup or an MTU
> change that would need scatter when the application hasn't enabled it.
> 
> Both patches change only the GQI queue format. DQO has a related
> problem that this series leaves alone: its Rx path ignores
> end_of_packet, so with Rx buffers smaller than the frame each buffer
> is delivered as its own packet. DQO should either chain those buffers
> or refuse that configuration too; that is left for a follow-up.
> 
> One more gap 2/2 doesn't close: the check reads dev->data->mtu, but gve
> never pushes that value to the device. rte_eth_dev_configure() sets it
> without calling mtu_set, so an application that never calls
> rte_eth_dev_set_mtu() passes the check at 1500 while the device keeps
> the MTU from its device descriptor, and on a jumbo VPC it can still get
> chained frames. Applying dev->data->mtu at configure or start would fix
> that but changes behavior and needs hardware to test, so it is left for
> the same follow-up.
> 
> v2:
> - add 2/2 to refuse MTUs that need scatter when it isn't enabled
>   (Stephen)
> - correct the DQO statement in 1/2

Applied to next-net

AI review had a followup suggestion:

Subject: Re: [PATCH v2 0/2] net/gve: Rx scatter for GQI

Applies to main; both commits build with -Dwerror=true.

Info

[PATCH v2 2/2] net/gve: refuse an MTU that needs Rx scatter when it
is off

1. rte_eth_dev_configure() sets dev->data->mtu directly from
   rxmode.mtu without calling mtu_set, and keeps already set up Rx
   queues when the queue count is unchanged. So stop, reconfigure with
   a larger MTU (or without SCATTER), and start without redoing queue
   setup passes both checks. Moving the mtu_set loop into a helper and
   calling it from gve_dev_start() as well covers that path:

       static int
       gve_rx_check_scatter(struct rte_eth_dev *dev, uint16_t mtu)
       {
               struct gve_priv *priv = dev->data->dev_private;
               uint16_t i;

               if (!gve_is_gqi(priv) ||
                   (dev->data->dev_conf.rxmode.offloads &
                    RTE_ETH_RX_OFFLOAD_SCATTER))
                       return 0;

               for (i = 0; i < dev->data->nb_rx_queues; i++) {
                       struct gve_rx_queue *q = dev->data->rx_queues[i];

                       if (q != NULL &&
                           gve_rx_gqi_needs_scatter(mtu, q->rx_buf_len)) {
                               PMD_DRV_LOG(ERR,
                                       "MTU %u needs Rx scatter", mtu);
                               return -EINVAL;
                       }
               }
               return 0;
       }

   Not required for this series; can be a follow up.

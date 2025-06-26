Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC7C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 12:55:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C89BE40156;
	Thu, 26 Jun 2025 14:55:27 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 5879E400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 14:55:26 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-7d3cc0017fdso100618485a.3
 for <dev@dpdk.org>; Thu, 26 Jun 2025 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750942525;
 x=1751547325; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wKd41P+T5GhofYR3Q7ypRD1UBzGszY6fVki80gAVqnU=;
 b=etIPvrkPC64VIDlXc+oeOzH8BzAWQzC1Q2Zy/ffKhAGTbhQ28c5ptyRFJzZrBcEJzs
 vP4GLZEOQ4C9sMjh6BCylktdEfDLYlnY3VQ9SI9aUZcTSbVKFDG0//zW/AftYCS3ThtT
 FW3hH/nSqBj/5EdGeEdqF3zCTdZjv6iXT8zfv3QHc/QnKRGTo2sGNfp4C7qV58LmNcbY
 MDYvmox+D4KaVthxH1eXJ9BD4HdxXzyke7ojKaP2lcQNxQIhBqtqzmRI95lrc30ByXHw
 da9Os2Bhs7z02dJqV+w8HnOoXZywvymbBN2saI8it4wC+WjU1oRIdg1NUU+y/v1DL8iq
 mbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750942525; x=1751547325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKd41P+T5GhofYR3Q7ypRD1UBzGszY6fVki80gAVqnU=;
 b=oJEjr489yGKs7OhuhuAJ3lJulq+1gs0N/mVBMWEWfQScfYXo2IFfhmWBKXMjkOhf+7
 /DGee/nUrpOsGyoT1Esqkcigl8Sj2KwlKD16DGZnp5rhAQElPFCiGCmYDYvVwC9HfyDq
 GUajsXrDjA1jAY8/EKkIhHn9Uw8IqKQZYCKtlXyW7jUY77Tn5Caeudxp1gzAc9azq4gL
 nmeWjH9XkD8OvS+CRzaqnl1YYyb2FSYNlTno1xeXwMfjPintGmmEjYpHqmaHg3uqUgyy
 xW5YSPoC6LkVCNw5d/Zq2O1oN1hnxur7kbUTSLYhOzi0PZoQ7EpoyZyeH+qWvYYkLptA
 OMkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzKwKAyWFnZ+a4YvTYlru0CfUrL4+5FezwVFddfKd+4imQrlutq8k3aEWYpItVBwTt1To=@dpdk.org
X-Gm-Message-State: AOJu0YwhNelomVkBSpONuNis6vx0Zi0mlklXsvlzqlWNG9wvi+R0PIl7
 unPWr0lq4TiTOkpu1p8anZ5IiroggkTXPj9HLqhBxsW0zMhBe1OaW6oLDrwHIOa4eys=
X-Gm-Gg: ASbGncsBQVquwTQ+TsLZmGAXoou8u3S3g6MvMl4sGLBkFNV5wV5qemiYz58GLrBQFc+
 3E2eRg3983ubHkHGOSxHdWFgj5EAqWNpmul+0zuWJKSc9UoW2IistYTPOMgsurZpJqfNKkSeTKd
 Fj2uS4/KFkwANGjFLsN1Cfwh0AM8F2NypU9/bx9f0TMcnCkFHJEr8zkV9wAAHD/Lo0J+Jakcu3Z
 ni9qQ5XFJAb5Z2V+S/glIMF1CmK2JIOElkzhuMRIBdz6ZR3MNq+oKu2tyDwrA7meoEU8KmsmXY3
 pY9W8Wcbc6ps2dKtlUn+IqtVY3gAkVEOxpfei3Q55XU0xFRXDeVDuGz4RxXA8LhnAO3QqAtO3gg
 uFK/zn822TjACGb1Sw3qesohYNG4JCdmwuyAww9s=
X-Google-Smtp-Source: AGHT+IE0uC8Oqt8oRw1DQpfuyPaMHsKLOdoGff5qGPUy9zZqMcCMkGJhypqWypClT0Pbw9uGOnqWrQ==
X-Received: by 2002:a05:6214:428f:b0:6ea:d6e1:f3f8 with SMTP id
 6a1803df08f44-6fd5efee1d5mr114901066d6.45.1750942525498; 
 Thu, 26 Jun 2025 05:55:25 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd7730acf9sm6877406d6.108.2025.06.26.05.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 05:55:25 -0700 (PDT)
Date: Thu, 26 Jun 2025 05:55:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>, dev@dpdk.org,
 Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH] net/af_xdp: add rx/tx queue support for af_xdp
Message-ID: <20250626055522.7aa59d41@hermes.local>
In-Reply-To: <20250618174103.1345466-1-shivajikant@google.com>
References: <20250618174103.1345466-1-shivajikant@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 18 Jun 2025 17:41:03 +0000
Shivaji Kant <shivajikant@google.com> wrote:

> Driver like GVE do support rx/tx queue configuration
> rather than combined queue. Enable AF_XDP vdev to use
> rx/tx queue configuration instead of combined queue
> configuration if available.

The first sentence is awkward to read.

Is there anything about queues in the driver documentation?

> 
> Signed-off-by: Shivaji Kant <shivajikant@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> ---
>  .mailmap                            |  1 +
>  drivers/net/af_xdp/rte_eth_af_xdp.c | 30 ++++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 8483d96ec5..c67caa7c9d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1423,6 +1423,7 @@ Shijith Thotton <sthotton@marvell.com> <shijith.thotton@caviumnetworks.com>
>  Shiqi Liu <835703180@qq.com>
>  Shiri Kuzin <shirik@nvidia.com> <shirik@mellanox.com>
>  Shivah Shankar S <sshankarnara@marvell.com>
> +Shivaji Kant <shivajikant@google.com>
>  Shivanshu Shukla <shivanshu.shukla@intel.com>
>  Shiweixian <shiweixian@huawei.com>
>  Shiyang He <shiyangx.he@intel.com>
> diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
> index 05115150a7..6899b6b165 100644
> --- a/drivers/net/af_xdp/rte_eth_af_xdp.c
> +++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
> @@ -168,7 +168,7 @@ struct pmd_internals {
>  	int start_queue_idx;
>  	int queue_cnt;
>  	int max_queue_cnt;
> -	int combined_queue_cnt;
> +	int configured_queue_cnt;
>  	bool shared_umem;
>  	char prog_path[PATH_MAX];
>  	bool custom_prog_configured;
> @@ -2043,11 +2043,11 @@ parse_prog_arg(const char *key __rte_unused,
>  
>  static int
>  xdp_get_channels_info(const char *if_name, int *max_queues,
> -				int *combined_queues)
> +				int *configured_queues)
>  {
>  	struct ethtool_channels channels;
>  	struct ifreq ifr;
> -	int fd, ret;
> +	int fd, ret, rxtx_q_count;
>  
>  	fd = socket(AF_INET, SOCK_DGRAM, 0);
>  	if (fd < 0)
> @@ -2066,15 +2066,23 @@ xdp_get_channels_info(const char *if_name, int *max_queues,
>  		}
>  	}
>  
> -	if (channels.max_combined == 0 || errno == EOPNOTSUPP) {
> +	/* For dirvers with rx/tx queue configured */

Spelling errors.

> +	rxtx_q_count = RTE_MIN(channels.rx_count, channels.tx_count);
> +
> +	if ((channels.max_combined == 0 && rxtx_q_count == 0) || errno == EOPNOTSUPP) {
>  		/* If the device says it has no channels, then all traffic
>  		 * is sent to a single stream, so max queues = 1.
>  		 */
>  		*max_queues = 1;
> -		*combined_queues = 1;
> -	} else {
> +		*configured_queues = 1;
> +	} else if (channels.max_combined > 0) {
>  		*max_queues = channels.max_combined;
> -		*combined_queues = channels.combined_count;
> +		*configured_queues = channels.combined_count;
> +		AF_XDP_LOG_LINE(INFO, "Using Combined queues configuration");
> +	} else {
> +		*max_queues = RTE_MIN(channels.max_rx, channels.max_tx);
> +		*configured_queues = rxtx_q_count;
> +		AF_XDP_LOG_LINE(INFO, "Using Rx/Tx queues configuration");
>  	}
>  
>   out:
> @@ -2215,15 +2223,15 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
>  	strlcpy(internals->dp_path, dp_path, PATH_MAX);
>  
>  	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
> -				  &internals->combined_queue_cnt)) {
> +				  &internals->configured_queue_cnt)) {
>  		AF_XDP_LOG_LINE(ERR, "Failed to get channel info of interface: %s",
>  				if_name);
>  		goto err_free_internals;
>  	}
>  
> -	if (queue_cnt > internals->combined_queue_cnt) {
> -		AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger than combined queue count %d.",
> -				queue_cnt, internals->combined_queue_cnt);
> +	if (queue_cnt > internals->configured_queue_cnt) {
> +		AF_XDP_LOG_LINE(ERR, "Specified queue count %d is larger than configured queue count %d.",
> +				queue_cnt, internals->configured_queue_cnt);
>  		goto err_free_internals;
>  	}
>  


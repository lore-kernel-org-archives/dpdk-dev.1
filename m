Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC4BCAC59A
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Sep 2025 16:39:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81A004066D;
	Thu, 18 Sep 2025 18:39:15 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id DB81C40687
 for <dev@dpdk.org>; Thu, 18 Sep 2025 18:39:13 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso12446666d6.2
 for <dev@dpdk.org>; Thu, 18 Sep 2025 09:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758213553;
 x=1758818353; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lxXFVuSR6xNlRw/+tu2Gk2EvUxuTwL36RPMVv5knNk=;
 b=eiVRpDNu2UhNiwQBq2EflLXj1WWVNCPFnuKFot7xOrP8dXU+5hyWXy4WNu6CFemkjG
 GkD8NjmbQjGKGWKg3bXHfoACLR5Cz99+GtRfkdE9Ax3gMVyMNFR6cWb5rTY+jpyJnCbf
 b370D47qQVJTy0iPopXwL+/VjqRGwIIgMqpsR83T/iiJ8AJ7AmCfvVT2RJbTo8SDPBpY
 ZyHHej+4x+MRgs/oUMAzPQ7bGCS9KrIensyjuq/2RZ8jb5sSg35XGhhWvBLa6rfrzkFB
 49x+s6OIot9LjNxaHm6YCcu4j7LRTf9F+QiomSzeVdOJC/CuLmnpTdky4C4AASWY0gdH
 IbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758213553; x=1758818353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0lxXFVuSR6xNlRw/+tu2Gk2EvUxuTwL36RPMVv5knNk=;
 b=ExwTCBtXrXb75X5RKbwaFcmHBaF1asORzsXzUvTiL0dznA7TG/uo3wCNom0moeNS2j
 /fpsAuJzheB1ldlynXueziwhga91DvqFAELYBW2nNK1avlYpID6b64WGBEba2yw7UAVl
 ylzWWyf+o9fK4tDAo83c0L5B04AaVwceLnehIQTQod20v+oxCwPJKQ6TSkKk1j4t5Kbt
 KE/kfWYh28fkLgiwCmb2GbEeoy3QAT2jhZlnjydAm8OJh8+jYSA4J5/BKbJ3bmy5p7yu
 vdBA5rrC1rd/+patDLwxlZ7TOARnqODIOep5+yOxr6F0ED9SLbUCuOPDKbmJDugBr7C4
 DhAQ==
X-Gm-Message-State: AOJu0YzU32yUqmHW6ARYrwWgf+reWebLta/YejIdriK/xZZXGgMIgIeB
 IfQtE6dnPvywhYmXvf2oLLagF/q9hBGRJrYbrVq5i9sySxcp6YS6BSNpzecvjqvjWWo=
X-Gm-Gg: ASbGncvM9CCS4gSVFtnb6yENNeUySTEAikFgceLSGnqa0lWtq39cUOnzKn9JvVN4rUL
 7yYEhhvYF7nxL2k6RJ3NxEjBuxxZttJ29Zi1FVXnPv1Ff2EzRzW77PiAcaDCf+sb+0DTWt0IoLA
 xIicT6R4r/YDjWvV2hl+VgBMLM+cSAKm9g+6H1xTRFLP025Xghzg41QOQLoHotzUFs8CVOjXfL9
 8wMlTcqHRNZVlr6CFBvrhCl5MWXJ11w6uLnW3x3Jy3NDKz+wdLfEcKTol6EMMpoIakIV43NeyUK
 tSMgxyjuRnAHjspzWfPUEjRpf09gGpfKx19gYQSAb+HzJ2S+AG+ALH8KyXC/0twAgyXbbiqdAqf
 4q9Fozgw04Ay5va1vgKcHubGX1NQmv4QcyeeSc7zjd9b6qnIcbx31e8En9vo7QCbHHiYclawcU9
 JtY07C4mxzrvgPOsf3SQ==
X-Google-Smtp-Source: AGHT+IFele5iDE7yIga3V8NOlxG/4ho/7hHgxqEj+CaeAzuMhcPFrHDpNFfliIKcOawSbGng1XWSeA==
X-Received: by 2002:a05:6214:1d2a:b0:78d:7116:8113 with SMTP id
 6a1803df08f44-799139cbde7mr1225706d6.18.1758213553093; 
 Thu, 18 Sep 2025 09:39:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7934636f947sm15099276d6.16.2025.09.18.09.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 09:39:12 -0700 (PDT)
Date: Thu, 18 Sep 2025 09:35:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v9 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250918093548.30e2883e@hermes.local>
In-Reply-To: <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-1-dimon.zhao@nebula-matrix.com>
 <20250917080843.646050-5-dimon.zhao@nebula-matrix.com>
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

On Wed, 17 Sep 2025 01:08:30 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static int nbl_chan_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack)
> +{
> +	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
> +	struct nbl_chan_send_info chan_send;
> +	u32 *tmp;
> +	u32 len = 3 * sizeof(u32) + chan_ack->data_len;
> +
> +	tmp = rte_zmalloc("nbl_chan_send_tmp", len, 0);
> +	if (!tmp) {
> +		NBL_LOG(ERR, "Chan send ack data malloc failed");
> +		return -ENOMEM;
> +	}
> +
> +	tmp[0] = chan_ack->msg_type;
> +	tmp[1] = chan_ack->msgid;
> +	tmp[2] = (u32)chan_ack->err;
> +	if (chan_ack->data && chan_ack->data_len)
> +		memcpy(&tmp[3], chan_ack->data, chan_ack->data_len);
> +
> +	NBL_CHAN_SEND(chan_send, chan_ack->dstid, NBL_CHAN_MSG_ACK, tmp, len, NULL, 0, 0);
> +	nbl_chan_send_msg(chan_mgt, &chan_send);
> +	rte_free(tmp);
> +
> +	return 0;
> +}

Does tmp need to be in huge pages (for DMA etc), or could it just be on regular
heap?

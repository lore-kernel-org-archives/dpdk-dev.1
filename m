Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B369C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 14:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8020410E8;
	Tue, 17 Jun 2025 16:08:33 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45]) by mails.dpdk.org (Postfix) with ESMTP id 1F95E40BA4
 for <dev@dpdk.org>; Tue, 17 Jun 2025 16:08:32 +0200 (CEST)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-6f8aa9e6ffdso52185646d6.3
 for <dev@dpdk.org>; Tue, 17 Jun 2025 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750169311;
 x=1750774111; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDc+tz0ZY0De/zT0Ei2G1pt/M9opSjQG41L+XFuPxqo=;
 b=hU4xt9sZCoxSaNetnxIcSB+6MfvZa9XuUtUaJTDwpuU8NoJzRir6UM6trmd55X7eP6
 2NhQklNNwlX1XqBKjtsu4t58lracpWnGWhW0gWPUGbHUFPJ1unvI9LmpRAHJjDfDDaRi
 ShgsqjS51kvXqnzhsdg3m6clabz1yj3HbFA7lrWjJBjmXUgYB1JV+2nzr5VOgIHWFuvy
 TPW2TJbInlFs749jU0gNKFzUgavcqp68Ejf4tmVCEgtCX5Xnkx8RvrETTZQn2ScFmzum
 srkuh5TJFg9wbQ/Cat0FP9MwoUvQoTfD10hVzcOoQCHOLgcevyTJe8Xi4Rp8WMUVQWmH
 JNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750169311; x=1750774111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDc+tz0ZY0De/zT0Ei2G1pt/M9opSjQG41L+XFuPxqo=;
 b=PAS6vj08w6yEFF9XfABKBK8tHJNIhsGWJnCWLgBA4BSfV0jvKEeCEM7jFiSiXmz07R
 APBt9L9tZrbHUn4aR5xD6uATA2ZuSCE3WmoWyGJMpyG6mqglIr3VRZLfuE4+ixI6UbHW
 v0v5yhfhHYs5L0BgnLz2ta9Qr+xGcxjRE2QB/gSK5/fr0cUIZX9DahmvdYkczw31Tg+O
 rg1AqT0jLLeYYN2hqf658FyqP73JnvKPKQN6rtIaVJct+dlj/nwtWO6NmA5QlZ1ibJuE
 U5mNvj58yfz27cu6JU+HYm3he28UxTYfOy7RcKRGRMI3fRBHNyjljZIUWJ2g4xQ28he8
 YkIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh8OAqsj1v7Zg9zPF4BWNADAxAL6cjUcPCM2Wj8VM4/hBWT1XXm1E0fwSAh4wbyOyJu/8=@dpdk.org
X-Gm-Message-State: AOJu0YySDz/JOml+iPd1sFc2QVq/c70ZDqlTlQgiU0I9phfP6WcKtgqu
 NNL2lSlF+WIgpXZbxBqDZl6EdRithotJPscmymv6Lpzu6Pgmu2iuFh2mN7ZzHyvif88=
X-Gm-Gg: ASbGnctcc0PJZh6uq0CPdoxeZH7jOnOoJGg0Ksd/SgRA5wc105To+bw2gVBmJRvBLa4
 V2oXIMsbgpqsT8wH96bD0DGg/uKpSmoMbaSy3xdGsRQ2TBgwQVIm7p9oQY0QWfVys8HjWBQwSCH
 22OqNIn/gmOIvpCYHehn2jeLq6Q4fJH2lDgrt3HLpqI//dFujHIDun1ogSr8cC7u6VZxOQyO+mN
 iih8Q/AKdvbuxVNL83y4wTH8FlPFIJLYVmp9b4M8FhEGC/FIh4EDayQJlf7K5JIa51uEo4F2PSW
 JGo3A9pM1EOkjSBmKjlXUH+zaHlRAccMyYsXODRnPYEKcICRIOmuxKY1bXXxUeNq+1TqJk6Rola
 4W8IcerS5GVtNAogzV5MZWzzuWQzJWD+21ncjLqA=
X-Google-Smtp-Source: AGHT+IEMl4xX1ZXN8wRMVwS5AqD2RMS8Fv5le+9D0eHIaKy1+2bfSu0PXn+dTQRV0uGolwm60A3IOw==
X-Received: by 2002:ad4:560e:0:b0:6fb:4cbc:5b86 with SMTP id
 6a1803df08f44-6fb4cbc5f74mr140004366d6.18.1750169311397; 
 Tue, 17 Jun 2025 07:08:31 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb53b5f7fdsm25101206d6.105.2025.06.17.07.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 07:08:31 -0700 (PDT)
Date: Tue, 17 Jun 2025 07:08:28 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1 1/2] net/zxdh: npsdk add flow director table ops
Message-ID: <20250617070828.47d67dd6@hermes.local>
In-Reply-To: <20250617093225.3570498-1-chen.bingbin@zte.com.cn>
References: <20250617093114.3570444-1-chen.bingbin@zte.com.cn>
 <20250617093225.3570498-1-chen.bingbin@zte.com.cn>
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

On Tue, 17 Jun 2025 17:32:25 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +	uint32_t msg_result = 0;
> +	uint32_t acl_index = 0;
> +	ZXDH_AGENT_CHANNEL_ACL_MSG_T msgcfg = {
> +		.dev_id = 0,
> +		.type = ZXDH_ACL_MSG,
> +		.oper = ZXDH_ACL_INDEX_REQUEST,
> +		.vport = vport,
> +		.sdt_no = sdt_no,
> +	};
> +	ZXDH_AGENT_CHANNEL_MSG_T agent_msg = {
> +		.msg = (void *)&msgcfg,
> +		.msg_len = sizeof(ZXDH_AGENT_CHANNEL_ACL_MSG_T),
> +	};
> +
> +	rc = zxdh_np_agent_channel_sync_send(dev_id, &agent_msg, rsp_buff, sizeof(rsp_buff));
> +	if (rc != ZXDH_OK) {
> +		PMD_DRV_LOG(ERR, "agent send msg failed");
> +		return ZXDH_ERR;
> +	}
> +
> +	msg_result = rsp_buff[0];
> +	acl_index = rsp_buff[1];
> +
> +	PMD_DRV_LOG(DEBUG, "dev_id: %d, msg_result: %d", dev_id, msg_result);
> +	PMD_DRV_LOG(DEBUG, "dev_id: %d, acl_index: %d", dev_id, acl_index);
> +

Some compiler versions will complain about printing an unsigned type (msg_result)
with a signed format (%d). This problem exists many places in DPDK so no urgent
need to address it.

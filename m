Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABCD58E43
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 00:53:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD43E402B0;
	Mon,  2 Mar 2026 01:53:00 +0100 (CET)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 2797A4028C
 for <dev@dpdk.org>; Mon,  2 Mar 2026 01:52:40 +0100 (CET)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1271257ae53so4499939c88.1
 for <dev@dpdk.org>; Sun, 01 Mar 2026 16:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772412759;
 x=1773017559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6gDdgYTHm/V4YpvZjeEqgtBhSKJYkHwpULaVjXC4Cg=;
 b=tGwSxJ1jFg9eogIHw+u+b2fhnPEXiqbiOhWGf7G9+inFNjObu/n3nfOdS0wjs5aYaq
 iC5rck8k9OoWBWiaW03y92yeqRSGbrvtvqhwdjVCblnx8DqzQOiV3sYreN/36SjY1Tm/
 RGWRyDZHHToILhGKIV01QlrawNGmPkE0FLZrpwEzSJ4/5HxPzcvoIa2i0STP9sZuuDlT
 h/qiLGS3AQxpKxmramIW9MBXjrFVb02nyHSUfsrfXXrNVZKll/MQ5gRd5GspQanXxb/+
 D2J0DnLL4uXZVnaJ8kJdWEOjr+/9nN9zfiFlCebgjsoowBFaHcTT7QC6lCwHqzdlt9xR
 Y7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772412759; x=1773017559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r6gDdgYTHm/V4YpvZjeEqgtBhSKJYkHwpULaVjXC4Cg=;
 b=SqRKeAaGnUKfFrG6V2ZIY88DzAgt70Ovs57ZNQjvHswYWovZttlz1sKli/66Vl4kbW
 uOByH/pBNA5hBhuyQY3iCSjzuFdMb8v0FEY2lOSchSlLQP8JsLJvMnFE1KK8BFTWAF9N
 kum7mZdDEGN1+mdx9htZ569QgKGwvzV/Ef3jM0fbUhbcX//6cFx+rNfWoPLdTVuaNqW1
 2LEufwstRC1g2riIeMyFOZek4PhDmpJ8WCbD9wUnUgorzSxzz2Sl1SySScjNw3hbHC4R
 EndQlYJnQBdH343aanOUou475Dw9ZRLtVXihLfeWDEOSUFfLitJsWTnYQcqJTeAsh+d/
 qflQ==
X-Gm-Message-State: AOJu0YwGJ2v6bMRypJSKFFMiynu0XTapN263qtVD6NT/+nXSvTxU+y2o
 eRvNq0I2XkMhHssoN5/SjkPI9F1waq5HVIfuVmcjh4eJOJeyTfW9mYb5YVAhAvzgZFQ=
X-Gm-Gg: ATEYQzw+3sROebwkZXMi/k3OrnRyeYcx7gT5xmDdEnHxfZduIOnE8LuaSTW5h4I5aSc
 eUxDekn063EbGmYKmeWWKNqPTUzVgC6sQJ2osh+/b39H0xltsUym4xaLZmCmox34fkIBpoZJbRr
 H62lRMVt3s3SSRkpzyALBFjawNI1Vft3Oee8jU9hcTk+bfd9qctVbivIhXUFNf66qlpQopLtJfB
 mZZFyJtI9cTXIzczVaCVgwiYPU0pW1s4RGa0bJEaA7zcSi2GtfgE3a/oZL4F0eh9N47fhOi2YS9
 B56IUpkVbJ0hX/opWJfb2ZZRXnpMKhVncdeBC9DJyHWhkYaFByk0EusdB3skHI2Dgy/ayplDMum
 Mh2GGM7mRYdgXhABX0R+EWjdxuJXbRcic3Zc1l2yNoJXrxXRi+jBDuYpw5a8Hjlm3ub+zf+5YIu
 +j3BJ1uefwBecEwqaSa76YzeGSUGpaWgHZjyQDuItpDEfrhAN3PZrCgC6lEU9FLo2G
X-Received: by 2002:a05:7022:922:b0:11b:9d52:9102 with SMTP id
 a92af1059eb24-1278fb7e384mr4840507c88.6.1772412758984; 
 Sun, 01 Mar 2026 16:52:38 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12789a32863sm11558718c88.10.2026.03.01.16.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 16:52:38 -0800 (PST)
Date: Sun, 1 Mar 2026 16:52:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Peim <maxime.peim@gmail.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2] test/flow: add support for async API
Message-ID: <20260301165235.1aa2003e@phoenix.local>
In-Reply-To: <20260301232931.444294-1-maxime.peim@gmail.com>
References: <20260225142310.51f75f4d@phoenix.local>
 <20260301232931.444294-1-maxime.peim@gmail.com>
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

On Mon,  2 Mar 2026 00:29:30 +0100
Maxime Peim <maxime.peim@gmail.com> wrote:

> +		switch (items[i].type) {
> +		case RTE_FLOW_ITEM_TYPE_IPV4:
> +			((struct rte_flow_item_ipv4 *)(uintptr_t)items[i].spec)->hdr.src_addr =
> +				RTE_BE32(counter);
Since spec is a void * you don't have to make it so opaque via uintptr_t.


> +			break;
> +		case RTE_FLOW_ITEM_TYPE_IPV6: {
> +			struct rte_flow_item_ipv6 *spec =
> +				(struct rte_flow_item_ipv6 *)(uintptr_t)items[i].spec;

ditto

> +			uint8_t j;
> +			for (j = 0; j < 4; j++)
> +				spec->hdr.src_addr.a[15 - j] = counter >> (j * 8);
> +			break;
> +		}
> +		default:
> +			break;
> +		}

Every time I see a cast my "spidey sense" tingles and look for code issues.

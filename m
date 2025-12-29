Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA8CE92FC4
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Dec 2025 18:10:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E4E340267;
	Mon, 29 Dec 2025 19:10:50 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 18B894025A
 for <dev@dpdk.org>; Mon, 29 Dec 2025 19:10:48 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so4421537f8f.0
 for <dev@dpdk.org>; Mon, 29 Dec 2025 10:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767031848;
 x=1767636648; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XKRhOyZ/SrTBogd3OQOH90raBarKZUWEmYPyQWX4Tw=;
 b=pCGBzeB+817uxfw7Dd3IdlUFdJIYUL9BZWUXNtqaSWfsv8gCK9+w0CmOAJ6ZHYeaAg
 bkApI45k6XHm3TbIdRWKvBJG3kWUWm3t5+OTLD/BjsTHRxijvoiw7KGMhVz7YZwB8pmd
 KGZ7H1sX7C8i30fwmh8ncIOx77QC0NlxuwRVm881wp0P+R0lUu4S3FO+s9graNAYb4Mh
 2c+mhDfA8EskH1FbtFc7HUM8tIyEd8lP5KBGdGpzB8nuu8+y0ON6+cN1kW+fw0OB0lae
 Tj8DVQIMsU0DUNBB6iyBJgRDVM48NLhhJ3Mep6sfcvk1y89pEG4KQBsx2GQKXo4917Rb
 l6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767031848; x=1767636648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9XKRhOyZ/SrTBogd3OQOH90raBarKZUWEmYPyQWX4Tw=;
 b=ACEuU//UGxz0qj/eUQYU4YhX9YkuiZqpG9Uv+aJjTtyEoBnpMHH9W+JPGtIQXgDrES
 5+zoQsm11grIhJhCDVZ0FhPVcnJqhFVjZ+9Y7csF1JhuzMX3JBWw/JW+DJ6WuryNU9Iy
 Psorc5mtgJ9Py8zUHfoyT4DFzPT8uF0DVG7sFNJu7HA/9ltsBR0APxRIOarzX0tSN2n7
 H7NobhgU3fiao5uBInIWXUipt/NUcOM9BZos4x0Yx7BzIXNvMnrY5Op0TRHrYpbT8sAq
 /17vLF7j51AeyXNt9u3eJzcWuFKCiNsDk16WONoCzEeEtL8ubs2mEEWIMcCwjGcL9TlA
 8RDw==
X-Gm-Message-State: AOJu0Yw1LxVqYM6H7LgLZAoM6tDCfA+68sYhd8PZXKxn6fmYygKlO3ne
 binACN+fge5jEsHGuqxyp4gm1AaV4BBmNJl1Sy2S2GzQ475pBdQWkJ2li2+TLxa5QGY=
X-Gm-Gg: AY/fxX5WwH75/qejtLCojy+11E33YTa4gYqIwty2wbpxHa4Q/grLi6TEMpUHy0hzjyU
 z1D44RFJCwT0rRLifSjSkw7vg1JESO5Kx0Lt3UrKBWKNDhocTnQF0I1obhk+pDc2792ypihB4hU
 9rVq++1jTrNqN46uuJoIgiI4ZROGpRxu5GkcWv25qeFLMMQbUlOFdwFyKIuX+qFbDQvy+QHvLVj
 G9gGJAQCupKxc3BOzLhL6ceDzQgd+2SMf+cq4eJExpM/SZOqKd8QbaKKlfcTkJEY5xuPbqhW3mm
 hA33cGGUYLTd97qBesKEiEDVF+WKQPuHreCXPYFTSeuJgrNRePlbKBkNLDw7+xI0kGv/mcKidY2
 p9dpBPMxkBb6lrq+aMm/YWxrq3wk6Wg8rYaOktFjvw2EZak/on5CRlzX87WAQW5YvjRdnWsRvdw
 vtoS/5udvXKpIFd39rvwUv1yJ3vvF9tEQ3meFk0W8NlUnHhWmKg4Ex
X-Google-Smtp-Source: AGHT+IFS8UOkzL5g1HkrqL63TxctbItm8OAirSO+wruSz5zCSf79fcI5V4uWxw/ls1E8Hb7THXSniA==
X-Received: by 2002:a05:6000:2303:b0:428:3fa7:77ed with SMTP id
 ffacd0b85a97d-4324e5067a6mr37433004f8f.46.1767031848433; 
 Mon, 29 Dec 2025 10:10:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm64069865f8f.24.2025.12.29.10.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:10:48 -0800 (PST)
Date: Mon, 29 Dec 2025 10:10:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: Re: [PATCH v2 1/2] bpf: add atomic xchg support
Message-ID: <20251229101041.5245f1ab@phoenix.local>
In-Reply-To: <20251218170914.7737-2-marat.khalili@huawei.com>
References: <20251217172037.59170-1-marat.khalili@huawei.com>
 <20251218170914.7737-1-marat.khalili@huawei.com>
 <20251218170914.7737-2-marat.khalili@huawei.com>
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

On Thu, 18 Dec 2025 17:09:12 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Add support for BPF atomic xchg instruction, and tests for it. This
> instruction can be produced using compiler intrinsics.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> ---

Should make sure that CMP32 and all the other current instructions
are also covered. See kernel docs for list.

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

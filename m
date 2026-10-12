Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9BFCA9ED0
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 056DD40279;
	Mon, 12 Oct 2026 22:27:13 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 13DCC40272
 for <dev@dpdk.org>; Mon, 12 Oct 2026 22:27:11 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so19600985e9.3
 for <dev@dpdk.org>; Mon, 12 Oct 2026 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791836830; x=1792441630; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xTrOVEk3p3aVetbce0uv3reeR+jR1z9pEPS53kbYF4Q=;
 b=A3zS3scNuA9o7Odg153ryXYcie+s/r9KtWUoieV9hq2SW7F2ofjCQ2mEHq07gB1tIU
 aXtKHxXcHP1+zbBu3lU7dDrlm2AYbHe4nzpxooBABq7gLL3nkCKFvAjJCw0hj0DHoJOu
 gF9SiUtr5p0JJWagjO39ha48AXgBzVePhHgaXhLfaJ7UE/QvbS95ToCrVM/OjaMveg/b
 mdgC4MENB4cFkRcHISIwNvcoIqbm4OD0Tx/QKPkXUWTc3B1t9QRazOrN2ruyLcsYxkcr
 WnCfhdnxpW/9+HDXzPa06QyJ1QkKo6CUQFPDqq04xFt5JtVWPUNTVC+afCJuD6ZjyekN
 tG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791836830; x=1792441630;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xTrOVEk3p3aVetbce0uv3reeR+jR1z9pEPS53kbYF4Q=;
 b=WOdRZ/aOFAtm0DwwWgeiNvRC58VyYHSM146sbhyNQGeHzzGkBE6Zf2nf6ZBVUlxoVO
 mxMGcdhrmur8BO37gTFxHUZU88JDPcgBhxuagEJ/ewR91/0mG0kDQ7X4PomlAYyGFWH2
 1A3kWr5c06DhCe3PdGUTmsbdYIeMOLl85OmE7jtVmil6fD8pP0WharjScr6QZX5dXpG3
 URtOIhhXF3lxYBXFcy8/o3K5eNDBHgafuz6DWB62ivcc498YQeGzxklTFH/OFmHotsaG
 do5Yrs7OWLXKAK+P+Tl4UpImtCFWipQgnmB7EszUAU0e5MB594fzkdo4DMdKkDhb2rjO
 J3Tw==
X-Gm-Message-State: AFq9FYIdIVYNUCXxCWnwfaoN4CurhEsTXEfL19jMt0A6pb6HsBSu4aFR
 oykW8B9bShyXWlXYPpD3LZgbM4MnTROafNFukmCZmNEO7RQQ74UovxQW
X-Gm-Gg: AYBFou0bcgj6W5ww+K+v8I2E0EHds9Nd+3gNgHPyig8kgoJFqypOoC4ElHp9dIqCLrn
 rkaqsaa0EgF1cxJO+xJHpxj9c7EMARUpzEw0oBpUnCnGghVLhrHH1ur+Q86rEZTtHlLDZ+GQVNc
 u0kiYXemI9AoNyUVZUsUxfxd1QDZMVIzPCzYrA0zAz4YvFQ6XjlYaP2dhrp0QRQ2/rFxw8zE3Br
 qPHi9aAhWM+U6ZmtgXJo0q/MtIQO/XkO3f/C1G30AUNie1V/UjKff91j6D7AOMGVUyM9G3nNXP/
 u1ldhOGA/IpWELSlIP3yn8LhVnN2LXBRz8g36dYWiiygkWjLb9l/yjNfWac4BI9eTp4o+FmJn2e
 e2euId5hBomgnjG598eXNRJPWi+N2S9DAJlZbi/I4PFOk4FKWryZO44ijJNh6ze86d4ReWH+SHU
 PrqvUzyVvrkY4s4+Iv9Xw/u9/bPiTQltwwmbFWrl9Q6Z2yYEx3xtfvXnrY3q0D267apSA=
X-Received: by 2002:a05:600c:83c6:b0:4a1:7093:40c7 with SMTP id
 5b1f17b1804b1-4a18e493048mr188736385e9.8.1791836830361; 
 Mon, 12 Oct 2026 13:27:10 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.48.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e48db03sm437376135e9.3.2026.10.12.13.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 13:27:09 -0700 (PDT)
Message-ID: <332e7685-e72b-48bb-b03d-9cbf71455660@gmail.com>
Date: Mon, 12 Oct 2026 21:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Proposal using RCU for callbacks
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
References: <20261012111324.6db17de9@phoenix.local>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <20261012111324.6db17de9@phoenix.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/10/2026 19:13, Stephen Hemminger wrote:

> The BPF and packet capture Rx/Tx callbacks use a per-queue use counter
> so that removal can wait for the datapath. In BPF that costs a locked
> instruction per burst. The code would be faster and cleaner if RCU
> could be used, but DPDK RCU is limited to the QSBR model, which
> requires application opt-in.
>
> The userspace RCU library (liburcu) supports other models, so I did a
> brief investigation into whether something similar could be done in
> DPDK. As expected, it also turned up pre-existing issues: the counters
> are wrong with MT_LOCKFREE Tx, the pdump one is not safe as written,
> and cryptodev callback removal never waits.
>
> I used Claude to write it up in more detail (attached). It is all from
> code reading; nothing has been reproduced or prototyped yet.
> This is too big to go into 26.11 at this point, will try and have something
> for 27.03

Maybe it's just me, but the document is a little hard to read without 
knowing all of the context. Nevertheless, there is no doubt the sync 
mechanism in bpf_pkt.c can be improved. It done today, it would probably 
be written differently, very likely with RCU.

I would argue for incremental approach however. I'm currently aware of 
the following problems, in the order of decreasing priority and gain/effort:
* Deprecated rte_smp barrier functions being used.
* BPF inuse counter is not safe when using lockfree transmit (Bug 2051)
* Code needs cleanup and documenting to make discussions more productive.
* Possibly additional safety issues listed above (which I don't yet 
fully understand).
* Missing features: multi-threaded data planes, multiple callbacks, BPF 
program reuse etc.
* On the very last place, performance; as usual, benchmarks are 
mandatory for it to have any meaning.

I think we need to resist the temptation to just rewrite everything, 
especially with AI. Some recent research shows that productivity gains 
from AI are very limited particularly because code review becomes 
bottleneck (tbh it always was). Test coverage is also clearly 
insufficient for any major rewrites of this code. A patch solving 
everything at once risks getting stuck in review for very long time. 
Perhaps we arrive at RCU solution eventually, but I'd start with first 
items in the list.


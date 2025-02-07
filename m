Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A55DC02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 09:18:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69A2D427D8;
	Fri,  7 Feb 2025 10:18:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8B3E6427B8
 for <dev@dpdk.org>; Fri,  7 Feb 2025 10:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738919899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/1NlXjhNhz26CmuoSuEuqT1Zy790wqVQUG4c/qbcws=;
 b=XyywK9q26W6lnITYbAYkZex3JLPPCZbEwFNrB4IC7z6oRrLO1JJGOpRq7A/9SKlEl7fca+
 jE29w04+cVTyxqr7riXv9ZdqdDGGRbqm6AcK+Oy7/1B5UxGuZcSjw5PndOpyD8/Cu/2Vjv
 JFwHlnsRfspo/5dVKD+B3WLz8LdCK3Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-HErrzCEBMJaJVD1yYuJBpQ-1; Fri, 07 Feb 2025 04:18:17 -0500
X-MC-Unique: HErrzCEBMJaJVD1yYuJBpQ-1
X-Mimecast-MFC-AGG-ID: HErrzCEBMJaJVD1yYuJBpQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so14433755e9.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 01:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738919896; x=1739524696;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d/1NlXjhNhz26CmuoSuEuqT1Zy790wqVQUG4c/qbcws=;
 b=tRIt7aXhRMtmqj4Sq9qmbRBV9Fi+jIDtKb3Ty4u3TkI7XJXkBbSK/EZZqkg2UhSCvY
 qu0LLr99/HKSWPdX84O01cT78KH3UJxfGee8afSsodaMdErTULZSAQynI8IywatWdbx/
 QcBqBU97bZmhMWbUjDuEEHh1Wpwm3NWofoiJdta7JFfdPN2+hHldJp4a6b8EmK4JWbEB
 wyDoWhJyQwGtMNMelfrvh7eETOEoqiJWIQYYtF8u8s1E8o0gUHF92RGThvJyf6rbzUvh
 8KAvfeutXZgs+M8xpum9XtesW97ixXyuT3rxgfxO5uAn/iQujFL0a1qRhsYYkOjc3KYq
 9gAg==
X-Gm-Message-State: AOJu0YznP0fuSIBjKwGGCs9jK+rxy67Dk6fqAoJ9CNWnEV/e2GMyzDgx
 ZZ2R1l+c8ZsJ2ywgCjRpO+Z0bpAiqTsN+xDi8ZL6y3PwnBRJRTnULNR7BaWOtQnnPxnsCVbN5qX
 jXHwAxF8OA6G3YPJTywE5Av64HEkoyCM0D/2DKXdE
X-Gm-Gg: ASbGnctn9FX/RkTTanibgZfle18JXy4dlA8EF8iMGAKON+zEMusTnQoXX2r7qDJPMT+
 riZylboLPnm3SKyeQjpkoyDkU4f8dh/l2IJlQUXITDG/a49D8yi6y887qqMEnG9MtTJHom4hK22
 fkpbzgfr9nE3dEJpckFCf411S/PCKoQeMBQ/PWTJO2PAxEcGo8SqtGFspbc/UujGs9cLCNNH33K
 znjc46e+Mp4aYVgc645BBkTsnd92+6AJBN1NFSRj2CkAFoanjM+QdDj6ZDCtwvnGFE0aClXP1Kr
 AAVbioj6bU/WmQbj2Cm4RpsZeyTU8tYt3zDUwioxRx8ObBXXc7YoE9ahJItX0VbuCnaF
X-Received: by 2002:a05:600c:3c87:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-439249d189cmr20578795e9.31.1738919896050; 
 Fri, 07 Feb 2025 01:18:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAHgtvfN9gBaKk97AVgqjiWee1j8ewVYgpUqeMpymTz745LgH2QYQbhLq0LgvK4Mh+kY8b9Q==
X-Received: by 2002:a05:600c:3c87:b0:438:c18c:5ad8 with SMTP id
 5b1f17b1804b1-439249d189cmr20578585e9.31.1738919895628; 
 Fri, 07 Feb 2025 01:18:15 -0800 (PST)
Received: from ?IPV6:2a06:5900:c00c:9000:256d:904:9b40:6d8b?
 ([2a06:5900:c00c:9000:256d:904:9b40:6d8b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf44f3sm85383465e9.29.2025.02.07.01.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 01:18:15 -0800 (PST)
Message-ID: <055c94e4-948e-4f29-9625-f9de269a4d9a@redhat.com>
Date: Fri, 7 Feb 2025 09:18:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] net/af_xdp: Refactor af_xdp_tx_zc
To: Stephen Hemminger <stephen@networkplumber.org>,
 Ariel Otilibili <ariel.otilibili@6wind.com>
Cc: dev@dpdk.org, stable@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Ciara Loftus <ciara.loftus@intel.com>
References: <20250116195640.68885-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-1-ariel.otilibili@6wind.com>
 <20250206204645.1564535-3-ariel.otilibili@6wind.com>
 <20250206134245.0989988f@hermes.local>
From: Maryam Tahhan <mtahhan@redhat.com>
In-Reply-To: <20250206134245.0989988f@hermes.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: abMCIDNqSYMBguVpJgcu3DVdJJVsT2NZcku7dRm9xZ4_1738919896
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative;
 boundary="------------wC1JzjRTItKIaMaWuznply0E"
Content-Language: en-US
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

This is a multi-part message in MIME format.
--------------wC1JzjRTItKIaMaWuznply0E
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06/02/2025 21:42, Stephen Hemminger wrote:
> On Thu,  6 Feb 2025 21:46:45 +0100
> Ariel Otilibili<ariel.otilibili@6wind.com> wrote:
>
>>   
>> +static inline struct xdp_desc *
>> +reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
>> +		 struct xsk_umem_info *umem, void **pkt_ptr)
>> +{
>> +	struct xdp_desc *desc = NULL;
>> +	uint64_t addr, offset;
>> +	uint32_t idx_tx;
>> +
>> +	if (!xsk_ring_prod__reserve(&txq->tx, 1, &idx_tx))
>> +		goto out;
>> +
>> +	desc = xsk_ring_prod__tx_desc(&txq->tx, idx_tx);
>> +	desc->len = mbuf->pkt_len;
>> +
>> +	addr = (uint64_t)mbuf - (uint64_t)umem->buffer
>> +		- umem->mb_pool->header_size;
> addr (and the cast of mbuf) should probably be uintptr_t since the
> intent is to do calculations with pointers.
>
I think it's ok as we would end up casting it anyway for the `struct xdp_desc`

/* Rx/Tx descriptor */
struct xdp_desc {
     __u64 addr;
     __u32 len;
     __u32 options;
};



--------------wC1JzjRTItKIaMaWuznply0E
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06/02/2025 21:42, Stephen Hemminger
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250206134245.0989988f@hermes.local">
      <pre wrap="" class="moz-quote-pre">On Thu,  6 Feb 2025 21:46:45 +0100
Ariel Otilibili <a class="moz-txt-link-rfc2396E" href="mailto:ariel.otilibili@6wind.com">&lt;ariel.otilibili@6wind.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
+static inline struct xdp_desc *
+reserve_and_fill(struct pkt_tx_queue *txq, struct rte_mbuf *mbuf,
+		 struct xsk_umem_info *umem, void **pkt_ptr)
+{
+	struct xdp_desc *desc = NULL;
+	uint64_t addr, offset;
+	uint32_t idx_tx;
+
+	if (!xsk_ring_prod__reserve(&amp;txq-&gt;tx, 1, &amp;idx_tx))
+		goto out;
+
+	desc = xsk_ring_prod__tx_desc(&amp;txq-&gt;tx, idx_tx);
+	desc-&gt;len = mbuf-&gt;pkt_len;
+
+	addr = (uint64_t)mbuf - (uint64_t)umem-&gt;buffer
+		- umem-&gt;mb_pool-&gt;header_size;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
addr (and the cast of mbuf) should probably be uintptr_t since the
intent is to do calculations with pointers.

</pre>
    </blockquote>
    <pre>I think it's ok as we would end up casting it anyway for the `struct xdp_desc`

/* Rx/Tx descriptor */
struct xdp_desc {
    __u64 addr;
    __u32 len;
    __u32 options;
};</pre>
    <br>
    <br>
  </body>
</html>

--------------wC1JzjRTItKIaMaWuznply0E--


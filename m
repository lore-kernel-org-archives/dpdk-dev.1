Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B61CE9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:43:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B71F84027D;
	Tue, 24 Feb 2026 13:43:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 75F8C40270
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:43:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771937023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cIL/SphHrQ/duHgD1Lx9rV0sH7Y2/jqu9PFL5EzQTEA=;
 b=EGzTCgtYT8ntlA3yafuAjBr2Gk++DteqOOsin2j6AJjTloy0rS8HQd+eisEd0yn3yiG3wj
 Ej4u5knmIy5FdmGeIrTJH+tZ+epBsQf3P4khgSF5+7ZyI553gsInovUFDJSxv1oE3zFuN1
 4u2SMEJCbN5jnBOWHJUeBKfam+rx6WU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-djvsYiO0MESt7-UPiGzbOQ-1; Tue, 24 Feb 2026 07:43:42 -0500
X-MC-Unique: djvsYiO0MESt7-UPiGzbOQ-1
X-Mimecast-MFC-AGG-ID: djvsYiO0MESt7-UPiGzbOQ_1771937021
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837c597cd5so5360895e9.3
 for <dev@dpdk.org>; Tue, 24 Feb 2026 04:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771937016; x=1772541816;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIL/SphHrQ/duHgD1Lx9rV0sH7Y2/jqu9PFL5EzQTEA=;
 b=Rzd8afQnEiGqc9lMVBuFPcEaQ7Y+FDdkaeADHVwx29U2hRZwt1JW6XYk8/m5rqWoyj
 FuPGHiRqkbbZUv0buPo0Z5fDtdeoLDKOOd/yO3uEo9+uwbrHXfgJ85YLygv2foDfTjR3
 tB3yJDZ2jYdHT/Qoj4K6B8xdv0U5Ut4U/+k6kJBe/QcgOe2X0Vto9CwH4XiO+CV0MO18
 7yzQa+/1gBlRFoqZ9eIVYoWGsK92GAqqzu3/mxEXC64NfJw/SAA6xT4VdJsaI7A8lLIR
 gf7SntA40k0T9o540NYutgIOs78Z/v4o85e0vO/iwyycpmb7bbPXX71zcDPv1hdEIo2c
 VGyw==
X-Gm-Message-State: AOJu0YzFLcqWJ726JEv5XVOgsL7vCUqvPH9bXCW2emOwSBSbccBA4j+m
 FaSuA7dotb//2aLeUP82dDHULq+m8iZVToc4h9ut/2IVmw/d2+WUlBGo7mjIK5VcSrC5tNsXrJx
 FaHWSE5Vv97VFe3gq2k7OCM5Khn+tqeomWVA1Gq/A706W8wHLY7By
X-Gm-Gg: AZuq6aIjhZ7/fZuDg9KrgxqJeo8EjEvlDNqbX7qD3gJtXqtFWvDfRY9NdTvVGiZUeaw
 TAvAM2/drDOTfw4qEXjBzMdIbasGq0rxJq0RWAx6OCRKv/3kNldkQ9xOTjjVU307HdC5e1c8LhN
 m/CF2Hp/64qBR5LQtiXX6Q/H8+Gey91JFBah/FdQL0Hn+6dos4dw9tx1K2ABX+Asj+TC5dtbfjA
 UrigIhbUngK/SBV2tDI38NXNiGwN2UElNgMZGS1gtWx5JyU45CaofriTGMIrb/6VT+/3At1WEeu
 vzn2gP+k2QdICm/cauZAV6Ur6o5ooXY2l5g0Rjv+ycFF+NKTFafRCZqlhUmxJNYQXkLnccm2k5u
 Rwns4eOoucz/pyAOpzkGILCk7
X-Received: by 2002:a05:600c:4749:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-483a95e6ceemr179076925e9.29.1771937015660; 
 Tue, 24 Feb 2026 04:43:35 -0800 (PST)
X-Received: by 2002:a05:600c:4749:b0:47e:e970:b4e4 with SMTP id
 5b1f17b1804b1-483a95e6ceemr179076325e9.29.1771937015108; 
 Tue, 24 Feb 2026 04:43:35 -0800 (PST)
Received: from [192.168.0.56] ([78.16.129.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f0330sm297145795e9.9.2026.02.24.04.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 04:43:34 -0800 (PST)
Message-ID: <314e5333-10a8-434e-955a-e37b690ab72d@redhat.com>
Date: Tue, 24 Feb 2026 12:43:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus/pci: fix automatic interrupt type selection
To: Pekka Riikonen <priikone@iki.fi>, anatoly.burakov@intel.com
Cc: Dev <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>
References: <d612fb276b9c8b173a5e476ca75b0460@iki.fi>
From: Kevin Traynor <ktraynor@redhat.com>
Autocrypt: addr=ktraynor@redhat.com; keydata=
 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
In-Reply-To: <d612fb276b9c8b173a5e476ca75b0460@iki.fi>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U_E9LdhYdIRz3Ng36p_yHrp5gkf4vans5dnubUjPw2Y_1771937021
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 20/06/2025 13:50, Pekka Riikonen wrote:
> Check if kernel returns 0 interrupt vectors and try another interrupt
> type in that case.  Failing to check the vector count can select an
> interrupt type that's unusable.
> 
> Signed-off-by: Pekka Riikonen <priikone@iki.fi>
> ---
>   drivers/bus/pci/linux/pci_vfio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 

Hi Pekka,

just one comment below about logging.

> diff --git a/drivers/bus/pci/linux/pci_vfio.c 
> b/drivers/bus/pci/linux/pci_vfio.c
> index 5317170231..02e7d7e40b 100644
> --- a/drivers/bus/pci/linux/pci_vfio.c
> +++ b/drivers/bus/pci/linux/pci_vfio.c
> @@ -237,6 +237,10 @@ pci_vfio_setup_interrupts(struct rte_pci_device 
> *dev, int vfio_dev_fd)
>   				continue;
>   		}
> 
> +		/* If no vectors, try another one */
> +		if (irq.count == 0)
> +			continue;
> +

This looks functionally correct. It will try the next interrupt type and
in the case where a user has selected a specific interrupt type with the
command line --vfio-intr, then it will return -1 at the end.

It would be nice to be consistent with the eventfd check just above and
add an error log in the case where the user specified the interrupt type.

something like below. what do you think ?

+               /* If no vectors, fail if there is an explicit
+                * interrupt type, otherwise continue */
+               if (irq.count == 0) {
+                       if (intr_mode != RTE_INTR_MODE_NONE) {
+                               PCI_LOG(ERR, "Interrupt has no vectors!");
+                               return -1;
+                       } else
+                               continue;
+               }


>   		/* Reallocate the efds and elist fields of intr_handle based
>   		 * on PCI device MSIX size.
>   		 */


Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33589CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 17:48:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 543E34026F;
	Thu, 30 Oct 2025 18:48:01 +0100 (CET)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by mails.dpdk.org (Postfix) with ESMTP id 912E940150
 for <dev@dpdk.org>; Thu, 30 Oct 2025 18:47:59 +0100 (CET)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-8909f01bd00so143992685a.0
 for <dev@dpdk.org>; Thu, 30 Oct 2025 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761846479;
 x=1762451279; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McduZKGuAuz5Lxyj8uIg+0XFW9q7ITOKyeP0Kb/w0PA=;
 b=cmHmkzmnksVffFsW2Ews6RtJcoSRDEyqwcyImTJxUVRxwXthF3VqNw2wmv68y1FXqT
 V7qH+6KzJc1sj7WfHaWTKFphdfpiAVdx2WPgM2gsWV7kcgH4rCPRm3jKkHxiDckpFGaD
 XjQzr5sMBZlPcJ1z1LhCapcDGhypBBQKXpi7PL6GA3uyUEU42Ph3a6T3teoJmimHuipG
 R/pRj7uzMMxQ3VsXu3CM6F+Nn6qE/y4Q06SKRphs0lRtvTgNXlyp0pCjLX0E0892CqM+
 F1BvWpdx/ilkyMK2kWl7oifQKxmbXJ2kJSwCUKXVEvmu7o9nejo9XYWVshVdKNIrRgi5
 M9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761846479; x=1762451279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McduZKGuAuz5Lxyj8uIg+0XFW9q7ITOKyeP0Kb/w0PA=;
 b=PPIyJ3+v5leZMtLaVajziQgCzeatJujJX7D6feDdrdQMpg8hC13Ug8BzgBZeiBjucq
 q5S+NxkJg28G/618g3CPCd07FScWs9SgfMw+eY17TSd5FQ2SugpwJ1oCaj6JSGSp3J1z
 Pd0ibwcPQzr8xRhnzNPf7KvzsOMKh38P3plUN8Bz3mioLwo1tWyo1gjKgrU2UD9nDoZJ
 H6LwWakV98RZXqhlGcjCvd1s+zWwib9Zk0W6xrMadR/4o75mtzvfh8yh2QumCIpy7Roc
 XvuyEjKMb3Z5RuC9uWnu/BC/NGNs8e9k+vcGdtY3XQYGI/y+DGRzT0PiL8q+FiipubAP
 R5cQ==
X-Gm-Message-State: AOJu0YxkLIhm6bU7nteG5M5Hl+9Fi9vU4yGzPi/kjcoXOCjv3+HtMj8q
 rWtfws//ZqHLtGzllP+5WT3TuzIlxJzADTegxOo+wCugrx7Wv4jpbROQnlAZNKQWzfY=
X-Gm-Gg: ASbGncucn/VZlfoICzt8+4zTSZ8DMhLsMfAVTpjf8M/Phqng0N+PTV8zdiDU+CpT7R8
 GAuAeDj1xfu5CpMEXHN6xZdTKsJlRViV2Vq9n+P9bswdWW/z7ZwbR44Z0Kz21F1UqNzhOa0YcpE
 1Yx/11DaXVFIQanAk+vEpu3ADv0Dz02zCR4f9EbErgmu7hfyhBtO815+0b8sGFj3jpsJjhAUQa1
 iWK82+1F6ATKNKGo/nubK68Qlx+DxoE7s0usUJ7Xum+ZA+aH8NMfoRg+H0zlsmDaD00/UxEPsCV
 vzSRhSaKqTE6ojGggbIyaU7lg2fDBegciR7GJkX0rm5KK82putnNzaEgDhwgmjue7cvlIdHwy7r
 T409WeLUWUOLu5tML8b5jBifCVhfj4sqYVX9I47ddKk6zEdUc4GrcBTBEUZQLnt1XoRmMkzayo9
 q80cTm9/Ti7AndE3gpXVFzzXUMnqBRbMo6iw==
X-Google-Smtp-Source: AGHT+IFvc0OzuqMZqTEs9FR8pRhxsYfD0bV2dv9vFPzpVHZhaRGxOboPPpCn5AVCo69Q8/cVfZOt8A==
X-Received: by 2002:a05:620a:1906:b0:892:9838:b16a with SMTP id
 af79cd13be357-8ab9b4a3f3cmr39932785a.59.1761846478364; 
 Thu, 30 Oct 2025 10:47:58 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f247fce0bsm1297301885a.13.2025.10.30.10.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:47:58 -0700 (PDT)
Date: Thu, 30 Oct 2025 10:47:54 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gregory Etelson <getelson@nvidia.com>
Cc: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz
 Sosnowski <dsosnowski@nvidia.com>, "Aman Singh"
 <aman.deep.singh@intel.com>, Shani Peretz <shperetz@nvidia.com>
Subject: Re: [PATCH v2] app/testpmd: fix devargs format in port attach
Message-ID: <20251030104754.2a6bd66e@phoenix>
In-Reply-To: <20251030171734.320367-1-getelson@nvidia.com>
References: <20251030092016.226974-1-getelson@nvidia.com>
 <20251030171734.320367-1-getelson@nvidia.com>
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

On Thu, 30 Oct 2025 19:17:34 +0200
Gregory Etelson <getelson@nvidia.com> wrote:

> diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
> index 2360da3a48..a2280d38d3 100644
> --- a/app/test-pmd/testpmd.c
> +++ b/app/test-pmd/testpmd.c
> @@ -3431,6 +3431,7 @@ convert_pci_address_format(const char *identifier, char *pci_buffer, size_t buf_
>  		return NULL;
>  
>  	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
> +	sprintf(pci_buffer + strlen(pci_buffer), ",%s", da.args);
>  	return pci_buffer;
>  }
>  

To avoid any possiblity of overflow, please us snprintf and adjust.
Something like:
	rte_pci_device_name(&pci_addr, pci_buffer, buf_size);
	size_t pci_len = strlen(pci_buffer);
	snprintf(pci_buffer + pci_len, buf_size - pci_len, "%,%s", da.args);



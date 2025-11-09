Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750ECCF9F8
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Nov 2025 20:16:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 479C44026D;
	Sun,  9 Nov 2025 21:16:08 +0100 (CET)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id BD8EA40268
 for <dev@dpdk.org>; Sun,  9 Nov 2025 21:16:06 +0100 (CET)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso1429808a12.0
 for <dev@dpdk.org>; Sun, 09 Nov 2025 12:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762719366;
 x=1763324166; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZRC6qgX/XyLaro05jklcHiSivgAtyUtOEJYzgrQwSk=;
 b=pkiw2JG9JUvSmRRr0CCW5CcvUvxN9E3g4R0VYrV9j8bqTPpiDQuXN2n9TaaEpxkveP
 rQE7TbfKaQn2j60p/KrNdrnay/iQwjBF2h7NavIQ4x0CWaIpN8+/VKhb3GM/FMpricDD
 OzPGKCqC0UWxGOtSw/9RIHuXr7aoNktmkzFp1bG17f0SZDRBlh4zqlluBcPjzUhdn4j6
 oMVtEuTup+8M4rI0bo+uace+kJ2am39VfFWI4MuzN3fJzrItnCI7P/yZ8pY82qyZ5tLp
 eJcYkIpexkLndPMhSeFwJTIScFhk+g+PxNyHFzxksdueAMYzxKv9+5007EvgWwckFJcq
 k2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762719366; x=1763324166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KZRC6qgX/XyLaro05jklcHiSivgAtyUtOEJYzgrQwSk=;
 b=dIIDY0yVhW4D2P9kRA5A/5uXpbxAmBDtsZcqOI7p+iBFm006/TwT3ANtBbNQenIDOW
 H9X7WYJN5lLBLWQ+XNpji5JK3DR33VjVzwZgvXZ8EV/WQ6dXomydbDPcHUxTuCcRuhKb
 SUulQXwYvxnZjKj7jbp9xNmiJAWSJW+xmDhIBxE27uAmgKh39aD7Vtvb/SohnF3AOG3s
 RMekTPG7fDAElN3RCo1kNAIGU08quUmy19IUeabMenZxiXrwjJ4pwoPL4foYpky7i/eD
 /7tawLPVZMhYdtFDLM5GmCmHcY+lcBK9M133EZMGDxkTJunTJ3ET6cT4Ey7i0DjShElx
 KOew==
X-Gm-Message-State: AOJu0YysX1E5yuqETKxlLj45a5IaBPgVg01WYAcOsRCBAjf3SQ3q4fMS
 u+9HkQkkgSWscB99s7U/NNv3ebMrF23rBozfM2toQOClb035drstH29ty903d8etSybxO0SabHK
 +ltaVSoM=
X-Gm-Gg: ASbGncssq2O7jbLXNV2/1htlOVe1CxbakwWstj0zWil/qzls0/ak/DjmdAoXqUcp+4s
 h3CqIkXDAdrd6jRlfjr/SWSDkTOaCh7Fk8c5ObH+8upS/FFCgCzX2EtE1fz4XsxFc8lWLbA8XLj
 Bi/GK9as47Sj3oP2wo6LG3imtzHXi+AMxb6YZ0AuY17MuRi0hBJthyD+hLEUEuhkS/z9hZ9uMdq
 1w4dTbBZVctQ3atH5dnWPiBXRiBtTUdkBAR3HXsuvJFcsvckTB3j01EOP0AAyQ/VCkeaVZbx7oF
 OQPnLIVy6CZ9aC7JniomBrDcKro9qaN6pRv3zZ8UNUO0rJYTmiVZucNzamib/1RGJcnCwFj/PF7
 +EHEnxX6jaO1SKV3L7v4qvixqe0UNCY2UMV/cFv8r374t2/Im/sI//tsLDmFe7KBAntdaNtDW+y
 7yPlwxs6TRszmx2KNaYXfbZaYExub8bI60Ujx5ontZXj5B
X-Google-Smtp-Source: AGHT+IGzD95U6Z4pFfdLSd6c4OGbROiHVwzzPXW72aFsBj+OF9p1wgkhPEWIgYCJO+bB5wLaEeaRbA==
X-Received: by 2002:a17:903:1a27:b0:297:ec1a:9db8 with SMTP id
 d9443c01a7336-297ec1a9e0dmr80782475ad.49.1762719365708; 
 Sun, 09 Nov 2025 12:16:05 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca1eb7sm123087115ad.89.2025.11.09.12.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 12:16:05 -0800 (PST)
Date: Sun, 9 Nov 2025 12:16:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Alvin Wang
 <alvin.wang@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam
 Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 4/4] net/nbl: update documentation and maintainers
Message-ID: <20251109121602.35144247@phoenix>
In-Reply-To: <20251107073459.3532524-5-dimon.zhao@nebula-matrix.com>
References: <20251107073459.3532524-1-dimon.zhao@nebula-matrix.com>
 <20251107073459.3532524-5-dimon.zhao@nebula-matrix.com>
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

On Thu,  6 Nov 2025 23:34:59 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> diff --git a/doc/guides/nics/nbl.rst b/doc/guides/nics/nbl.rst
> index f41da20eea..9657ee2c87 100644
> --- a/doc/guides/nics/nbl.rst
> +++ b/doc/guides/nics/nbl.rst
> @@ -70,6 +70,13 @@ Anolis community:
>  Alternatively, you can contact us to obtain the `nbl_core` code and installation package.
>  
>  
> +Coexistence Between DPDK And Kernel Driver
> +-------------
> +When the device is bind to the nbl_core driver, and IOMMU in passthrough mode,
> +it is necessary to force IOVA to PA via EAL --iova-mode=pa option,
> +DPDK works normally only under this configuration.
> +


This paragraph is has awkward wording because of verb tense. 
Also in RST files the header needs to have as many dash characters as the header above
and use highlighting with `` for options.

Better as:

	When this device is bound to the nbl_core driver and IOMMU is in passthrough mode,
	it is necessary to force I/O virtual address (IOVA) to be mapped to physical address (PA)
	with the EAL command line option ``--iova-mode=pa``.

Probably should also check for this in the driver, and warn user if not set.

Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC34CC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:12:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DB1A840A70;
	Tue, 13 Oct 2026 17:12:04 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id CE4E140A70
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:12:02 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-381b831d535so3830329a91.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791904322;
 x=1792509122; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7f7eeDyid9Mnnv5IPvKQijJ3uczezsoITB9IXGTE6lo=;
 b=F5fdzyAR2sNp2DdD7PzFe6voxWUDJvKxv8zPQwnq8uoPYbBRdqQKcEfKxqm7qU8+gl
 VZcxxM0Q9yEhvHLT/LriqOTHJ0I+9C6ccrr/o03PnUaC98roliGaR4w0lM0s7yWrijNk
 HH1ikgIisuN9iiBr19GU4CLdU73rpfUuZH9MVqDrXt4jb7DnUq9/LEeDMGL9dGi1mDyQ
 A38ut01c9Hg0eIPhgwZpGStCWYJfrga6uwvba4ZnPFAphBrccOG5qseqkSZgDbTi7meb
 n2Sve/feBWqLYnY1Uz/mkq0CL//NDBCE+gkqk8Kf63b+G1FdpIPWVFVA9cOft4jfgLsg
 O+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904322; x=1792509122;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7f7eeDyid9Mnnv5IPvKQijJ3uczezsoITB9IXGTE6lo=;
 b=1WlglvPi8t87S+boumLdh3VCFaMo5VzFRaQ0B5e4cLz6kbnD3ivCEi3z8oNEFuJ0YF
 Haa+bX18S0TRh/aCXfRb5SI7EWynmpGEhaQJhTM4Q5IRuTDBK0tciZiS1eq4hAkL+ksl
 k0Ftp54Sn9Gbr811uCU7w0SmNAEmNqNcGAFJHhhI3gvn+WNge/PXPmistWPmxqWu62/P
 JVHRqXe+vWuvDiABcdDqqMdnD9TC4XG3ssfRsX7TqS4I4CsRc+617xzKd6ZvJgfHZh80
 j1D5EYg4+G6Iyd+6e7w7FheoHsINjz/Rd6/wAylloZyBWDWY64Fba5CAIviw6iil9AVL
 iFDg==
X-Gm-Message-State: AFq9FYJ5Rq8m4DW4W/9zX5ILG+655h8S80Sjf8Cxxk0b3eqB+VCyYSGG
 POhPCMaRwZUgqJMw6EIJ+vq4RbLRwOtgbuNQ+y7gEbOPS8pss2BzEYcJ/rd6f5ezUVM=
X-Gm-Gg: AYBFou22qlfPthTdxuYV0YjLgMsFDyXt2cjASuFVpktYAntY45IQbYCaHf5j3yDc5B2
 4P/3pcjMNQ2tGN2Sqor8MHsyhdVnX++CTalZ6OwiRzuVj2wAyrEGbjBi8/hFUIWaY1TfEvmzvLZ
 1Gpy5575h0G6CKlZP30aQ5kldcryXQRb/Cmc3mEN5CLpbBI1xVKTHDaZZkFGu1xEFub/G0zie87
 PY6bPfq/oUJsb5TVBKAeLDz0v6rmdPLi3N1PBNDoyieg+ZPqx6WGaRLM1UtIVe3hysEpRU8Eov7
 foZRrxRDEwT00sIwcIfAohmPmFY2qaK4IzZOl0rTFPTPAZggkq2PpCFjQPSexYeSRPihmyOxwqD
 1dEoAZBJgFstsVvnnze9kBr76lhhG3y3/emNDSmjsLUBa26fTpEOx8bGudGJWbYeBEv0f9uOk+B
 TXa9XAIBZt3avp2+i9hLvXVNdNFs7+Ex43OUE1QDiBLYW0oXVj8SKPCKXT360VDON0A+etKBi3J
 iKaRQwimxJoY0qTY4BHW1aMGAjaUuH5IXTAn6vF
X-Received: by 2002:a17:90b:5343:b0:3a8:9d0d:ca50 with SMTP id
 98e67ed59e1d1-3ab3a956dd3mr11072434a91.10.1791904321743; 
 Tue, 13 Oct 2026 08:12:01 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f05083fsm35116a91.1.2026.10.13.08.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:12:01 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:54:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [PATCH v9-S2 04/13] net/dpaa2: support MPLS and PPPoE flow
 distribution
Message-ID: <20261013075411.29239055@phoenix.local>
In-Reply-To: <20261012070444.2149617-5-prashant.gupta_3@nxp.com>
References: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-5-prashant.gupta_3@nxp.com>
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

On Mon, 12 Oct 2026 12:34:35 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> +		ret = dpaa2_flow_identify_by_faf(priv, flow,
> +				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_FS_TYPE,
> +				group, &local_cfg);
> +		if (ret)
> +			return ret;
> +
> +		(*device_configured) |= local_cfg;

Unnecessary extra parenthesis. 

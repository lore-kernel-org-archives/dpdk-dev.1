Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C90EC1112
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E5E4025E;
	Mon, 23 Feb 2026 18:10:10 +0100 (CET)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53]) by mails.dpdk.org (Postfix) with ESMTP id AF8654027D
 for <dev@dpdk.org>; Mon, 23 Feb 2026 18:10:08 +0100 (CET)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so2639003a34.1
 for <dev@dpdk.org>; Mon, 23 Feb 2026 09:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771866608;
 x=1772471408; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTV/AXoA7cBzo38mAFPJTJ4VGxh8tZ7UfatXT3CUFnk=;
 b=xN58A/0AmnzFV0UVjoSbZJ0SSo6D2jDFSNtx2GXl5scicZ2pR3FlKE5J2BBeoD6MDj
 +MJ5fIJ8qQdnq6lR0lBTC+0v3UcTVpx9ucFoVnLsZifMVaFMz1HYSkdLmrI6I3btaFko
 wyQh7whSNo8m6jAZminODoHDsio8leM2inTBCVHS2NNnMNRmeLl/mWA4sQtEula3B94o
 PYboLYv2WhGF53AzOaMJ204xHYiw2vnykXFLEpPBn3X4Rn8n4d+WR5ghm33FM+ic5rJA
 d5mAWZkPN2p+wc8k2HhfxFvwctGUKE/7YaF6awhW/om2AZr41g9eLrM3Fds/WoL6kN7m
 YQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866608; x=1772471408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uTV/AXoA7cBzo38mAFPJTJ4VGxh8tZ7UfatXT3CUFnk=;
 b=nqr3Lo5xs+A96ro3I49wb4z3/gXgb4nbWABtZZGuq54r8g0y9TmSs6gh0+2on0f15M
 HjjqTW0s2kAGBtlrSVurEk1HVEsCrwjYeU/co5pdz1qEmjPFdApCDI0u0I9l9yLEb+MI
 5VnfddiSYy0lZS8hFqrLgbSRJfJUZQ+d3nnWd5ieBQzUOiuT+cIZGwRDQV4ubnZKgZpL
 hGruyJAa4woS9hwOP28jE25J3/ITpiytHpVMP8kyO5H9KQ9dwDOmNQ2lIFoUj03dU0da
 gZ8kH1iv8idCyBwCjJyuRjv77312oEyTJae/J0PQ/uCFeJff4DGskvD/A2TxYb1hONC6
 kHQA==
X-Gm-Message-State: AOJu0YwW/4cUOZSiktY+jk6QY1LR0vrD/c9TR7Zut6EdQMNL1o/raXnS
 TqiPKNgAgh47iWCyAQDP2WmYDsJcmb5cmQZlG1H4B66ZdNSZQ5h698caf2OaumPuVgQ=
X-Gm-Gg: AZuq6aJ4yMO27FCFssa0QI1X8X3RjbMiEvzKPacgrZXh6i3ZnzNO6r4zNRuktX++9Nx
 yTfnDQ7RsJNCceWUKWAxDIqIVYPQkUj5997ZtJAM1HxAZrDAze8q9MtHQuUrYBQu3rotcf0YClj
 BbUwDizNWFQP7QxThXkBj3hmqPLe8QpjU2CB/ErF39NFwKM1QyC4yUKwzbk61k5ZMQ0c5KkQLca
 u+AJ5O5kVfT6rQESxbetrP01B4eeSnjNsNcNK5t6dddVhp+kvkaTmzK4GlTiuz0Zl0EcYxUKdB1
 rZo3MGwdv7dpFNdcZ6cOLOv2scXfvE+RRDDM3IHzGTz+AmCuSOb/yB7jJ/WIG1bt2SiNFxv7p0O
 YjnX6O4sTCyaj3nr3EVuGk6h/F/wsKQtyYXLRJIot6/nRX1ZA+4djfSTYlPm8AZPYYF1OZS+zMn
 BYohBUTdwDbVvs9RCH3v4UHCXpBTCZcjMYEHu8iGrpcK3Jh88kGRqIDEWoyauPLgDE
X-Received: by 2002:a05:6830:709b:20b0:7cf:e3f3:437 with SMTP id
 46e09a7af769-7d52bf3eca4mr3235198a34.22.1771866607867; 
 Mon, 23 Feb 2026 09:10:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dae9sm7634421a34.20.2026.02.23.09.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:10:07 -0800 (PST)
Date: Mon, 23 Feb 2026 09:10:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: Re: [RFC] test/eal_flags: suppress vdev_netvsc auto-probe
Message-ID: <20260223091005.6733c193@phoenix.local>
In-Reply-To: <aZyHm4EmcMGe4ylr@bricha3-mobl1.ger.corp.intel.com>
References: <20260222221542.804546-1-stephen@networkplumber.org>
 <20260222184944.0b43ea22@phoenix.local>
 <aZyHm4EmcMGe4ylr@bricha3-mobl1.ger.corp.intel.com>
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

On Mon, 23 Feb 2026 17:00:11 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Sun, Feb 22, 2026 at 06:49:44PM -0800, Stephen Hemminger wrote:
> > On Sun, 22 Feb 2026 14:15:42 -0800
> > Stephen Hemminger <stephen@networkplumber.org> wrote:
> >   
> > > On Hyper-V systems (including Azure-hosted CI), the vdev_netvsc
> > > driver auto-injects itself during vdev bus scan. This interferes
> > > with the vdev flag test causing the nodeaction subprocess to fail.
> > > 
> > > Suppress by passing net_vdev_netvsc,ignore=1 in the valid vdev
> > > test cases. The scan callback sees it already in devargs and
> > > skips injection; the probe honours ignore and does nothing.
> > > 
> > > Fixes: 0d684a783088 ("app/test: fix and separate --vdev unit test")
> > > Cc: stable@dpdk.org
> > > 
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>  
> > 
> > Self NAK
> > 
> > This is not the underlying cause of the test failures.
> > The issue is likely parallel test invocation overlapping on the file prefix
> > which is already addressed by another pending patch series.
> > 
> > That said, something should be done about vdev_netvsc driver and github
> > interactions.  
> 
> I don't think it's parallel invocations - we don't run our unit tests in
> parallel in github actions. I'd also note that the current issues started
> appearing when we patched in support to pass through the drivers path to
> the secondary process calls so that they could match the primary instance.
> Therefore, I still suspect something in the pci or other bus scanning to be
> a problem. Do we need to disable the netvsc as in your patch and also pass
> in --no-pci to the test cases?
> 
> /Bruce

I am thinking that vdev_netvsc driver hack needs to have a way
of detecting whether it is being run in a test. Maybe getenv("DPDK_TEST")
or some other github detection.

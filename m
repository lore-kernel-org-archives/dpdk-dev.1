Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB006C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:11:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3624E411F3;
	Tue, 29 Sep 2026 16:11:02 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id 401AC40E0A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:11:01 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc4cdc0d663so1743682a12.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790691060;
 x=1791295860; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CroVNBfTqdClz2P0axpwf2OfF2SvS8KgrGFR8BBKSFc=;
 b=nBVL0eXuaX0fF5JuQBWQWSyRizuw8YmGP+94/QqbAtR/OaW7HRkIT5MLak5R3iGmVG
 pQCR/5ejl5xhBXc7T6rx8+7pmwlOCTf5O9p6SopS14Pa3Ueiep9HZkYuY2kjvqOXbwmU
 xQbOywVCpw3cDVMEuOsYwHx7TW98hBfDfhoxqrqvep+SJ5Qp3GxOEXlMhUEhGQCUr8iv
 8xJzyLVXKZGmi4pabQPi+hJtSN3RR50xbe6pwxQE5usma3MtkjgxzGFtKJwJMquVTz6j
 cxGJWpIZky6ZXDvnADzUcRKStq91X72iGTW9YYuRUMZ4Pid+7LS/XjMvb2NAyGHIRp6I
 MLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790691060; x=1791295860;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CroVNBfTqdClz2P0axpwf2OfF2SvS8KgrGFR8BBKSFc=;
 b=ac7fyBy3gekgIAfY8yoj7jJioBf1J3lXZhb5pV+X3wAjSiHKrMjxcsYmrg9UD2OSDR
 u7QkYOvlMJku5abaowDFrHrmZ/VODRx21I149Ff/8lIAVeACDizH5vYunUdF1Fpai/oM
 5580k7rKRctp4RRORIoaXdl1AsEdgsaoNAy8r2zx5vKSBS0/JVvofWCuy2AvMiibf/SX
 vfKZ698ZKmuX8uwDWWHXseQn4fPGFl9dE2n2R6Ube2GZVyliVVQ1kw3I/or+9yqayyTc
 Lhcq6c51hjQPO/rtN9LIB9TrGv/rFdjq3V9Gd0LzKN+arLKt3QqfevqIUi/DvCxlNNDs
 nXyA==
X-Gm-Message-State: AFuF++k/VC5iOs9qK+33FYaDljzw1lGxZn/9pICXruM8fSuAyqZ43meI
 +HaZIAhxzQDAq3snO1UfTABddQbw79FyhnGgo9CLaIguPLLqbXoUEopMtib9D91cVNg=
X-Gm-Gg: AYBFou3wx3ZD4QxrgEI86YkSBeC5kg1FzFhrcgKnj9atO5l2QXNq0/e/2bHnW9l1Wm+
 nkI0Rca4LrKvjh1FyOcdjZcN1UuwM7nBnUbEEHkfAEX/5kIfAVuIO1xvOGz6JWP0FurMMOSpnAC
 Z0QO5THFwyOqMlqWXV8+oeyt+2a73jKYJdHNyPBB0ke222N4FvqB5bJbd9Bxz249F/70tsLMwJC
 n+N9kEozfCNppyBycnalkdIBqFcy/qD+QYh8CeY3NUq6Jn6Om12AYVBfdwG/nsHhjvdf50sO9E5
 8refMQiPmkGnjkGJ29XnN9YOEpJseI4Ku6d4mc7X9iOlqJH2xV5iAx62ivRyagBOIJPSSZ+0z2q
 wDnZ4WlK4ILcey8ZZN87b9Ztz3cteUryrbBlOTQY94dMXVOGLaejLuPA7YB1ygQZkTiKHMusaxV
 0xoVtyBv/HBAoBLM+bLg7lOaN6jIvzBNHhrD+DVel/HHNNJUol3JypG4Tr4OjTJioOFQeOS1lO7
 mkQrK6j6A5G53NY1yzv0YY54eGua4VPxxmVS9R/
X-Received: by 2002:a05:6a21:a88:b0:3de:7dd6:ff9d with SMTP id
 adf61e73a8af0-3de7dd74e3fmr2471363637.43.1790691060187; 
 Tue, 29 Sep 2026 07:11:00 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7ae09698csm3649707a12.31.2026.09.29.07.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:10:58 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:10:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: <dev@dpdk.org>, Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Thomas
 Monjalon <thomas@monjalon.net>, Ravi Kerur <rkerur@brocade.com>
Subject: Re: [PATCH v2] eal: fail initialization if TSC frequency is zero
Message-ID: <20260929071049.02added8@phoenix.local>
In-Reply-To: <arvD4gDTBcNFAdAh@bricha3-mobl1.ger.corp.intel.com>
References: <20260927195440.89193-1-stephen@networkplumber.org>
 <20260928231637.733450-1-stephen@networkplumber.org>
 <art5SCrwPVJ8JkKQ@bricha3-mobl1.ger.corp.intel.com>
 <20260929064208.6c7453bb@phoenix.local>
 <arvD4gDTBcNFAdAh@bricha3-mobl1.ger.corp.intel.com>
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

On Tue, 29 Sep 2026 14:57:54 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Sep 29, 2026 at 06:42:08AM -0700, Stephen Hemminger wrote:
> > On Tue, 29 Sep 2026 09:39:36 +0100
> > Bruce Richardson <bruce.richardson@intel.com> wrote:
> >   
> > > On Mon, Sep 28, 2026 at 04:15:58PM -0700, Stephen Hemminger wrote:  
> > > > Many parts of DPDK will fail with divide by zero and
> > > > other errors if the initialization logic ever TSC hz was ever
> > > > determined to be zero. This might happen on a broken get_tsc_freq_arch()
> > > > or bad emulation in QEMU.
> > > > 
> > > > If TSC hz is zero, log the error and propagate back to
> > > > fail rte_eal_init().
> > > > 
> > > > This fix doesn't need to go to stable since it is a purely
> > > > theoretical problem; we aren't getting divide by zero reports
> > > > from users.
> > > >     
> > > 
> > > How was this discovered? Is there a coverity issue id, or was it just AI
> > > discovered?  
> > 
> > It was part of review of pcapng timestamp calculation.
> > Kind of funny, AI spotted overflow (which I verified) in the code which
> > it had previously helped write.  Then it was asking it self,
> > "what if TSC was 0". I didn't see how this could happen unless QEMU
> > had some broken CPU emulation.
> > 
> > To me it seemed best to fail fast and die in a safer manner.
> >  
> Agreed. You can add my ack, either for this version or a new version with
> the "set" function renamed as I suggest.
> 
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>
>  

I also updated comment to rte_get_tsc_hz() since existing
comment implies the value could be different on each lcore.

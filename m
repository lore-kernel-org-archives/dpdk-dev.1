Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD2CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:23:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47AD94021E;
	Fri, 29 May 2026 17:23:33 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 19A7E400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:23:32 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-132830d8281so2246613c88.1
 for <dev@dpdk.org>; Fri, 29 May 2026 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780068211;
 x=1780673011; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtCnmbHTvwvJ+1z+puwhWmzmgey+2uN8jmYzi/tdNu0=;
 b=FBSEQEuJ1vPt2EQEM/VajYYBSQDBqUr1j9biNRouUjqSbxcOLF7fsMe8G0OabexIuC
 hSAQd7k1O/mHoEX+HWYunYVQJ8wnnjGhaGVBce5PBki5qIK7FC1gumeCOrxjvwmzF0j5
 n2ylneF9r01HArxCOde0f1fkiPAn/f0J3HtL/XsE9cYtZotjF6YgM5Zy5jdEL/eT5X/V
 KQ5TdQ6F5xxbEU3QAK1qf4YZv/Is8nIlFQdxf4FZ+Ykt9OXz32vF8Fk1OzENR6MSbctr
 L1sNVHowahtQNwMLDiCXR8evWsq+0NwKDcWE2UgSvR0u5qqA8jTkS1N+BnwhFHvhHYcl
 4GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780068211; x=1780673011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jtCnmbHTvwvJ+1z+puwhWmzmgey+2uN8jmYzi/tdNu0=;
 b=lInlkbMjViI6yjIbjCxZwQyKSOaFvemD8zJuEoT9b1g9wiizD0d3QVk2nQTodgyPv5
 9s7FpLepdV6fHwzsJ/wQut5kCQIOyQ+uXQBUr/kmJET1KtWxHnvStECciziRCUMGlzLG
 BxtP78tzVLr1TIk2TFucIqtRQ16s+7slbMiL2z+iVVfFiFnACxL/cClGoWY6oy2FFMRc
 VvfcajfkWDPFau/Z8HpSFy/UA7jOOT6QyZsm1b9wgGv+8FPSoGaAAD5HAGnkzv7GDozN
 5Zz2J/V+9aKzjZql47GJ+L5R3evz2/iCihovYNArqyBgsGr83r5rE9kBSXReGpYpbGMD
 EZqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dKKuy/B9S9Y4jzhqyhLSNYOL0tnbAAdhkRpHRtACi+sL/AEJmVf8GxLuU6Pciyqdb2UY=@dpdk.org
X-Gm-Message-State: AOJu0Yw/BORMuvVfDo1SO9QDCqbqpuJcnsunpwhY0CE1VyJCakkdRnDX
 tp2CpLFQ1UAnPLga9GSYHWBD7nvQ3pF7/biwfn0bO8osxMOk64MtBltsIVbdFRQTQmE=
X-Gm-Gg: Acq92OHCOHpD90w0PJsuoFh3dTCeuTf1lfmduZ654NbMXrPn8I20cQj2YkDbv5tlnfO
 K/lqnD2/NhBlQA5Byi90U1wJPCDubRErhjWC53xKeDrzvqZCP55wG2TLfoB2DsfcHjefAK1gAIF
 WH8uo9yXmroYcCVf8LSO3MoENyuH73LC/onIdEle1qeJFNLG4yB7BfmZ82s4Ila0RrBb4HMPlgJ
 U6FgBXyrUIK/OqIk+GUE3bbqniFM/sa8AvrlX7UpxpSzHDKUUEzDsRtiYmEr2dw7JZNMmvelGET
 ptQ6FI2V1tWi5hVwaTgFzwNLHrx9VgrrEsJzFQO2oKOH7ujfw0KcVxO0f8Tx2eYMbtVKT3998pI
 pKBkcXEk5wMXThy/he89OcwitiqVI0usdy3Hk82BA+2EahMN4ao0N2QeiIeyfA8yku3c2iGpNSy
 zxzBUuPca1PmMtffaD/WDzB/8EoSX8Rfm6mYF5BSoMPjzbNWhYZN0YaqpveebQ1ksqQOd/sWpoQ
 L0=
X-Received: by 2002:a05:7022:117:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-137d426270emr47582c88.20.1780068210751; 
 Fri, 29 May 2026 08:23:30 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm1282160c88.9.2026.05.29.08.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:23:30 -0700 (PDT)
Date: Fri, 29 May 2026 08:23:24 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Sudheendra Sampath <giveback4fun@gmail.com>, <dev@dpdk.org>, Anatoly
 Burakov <anatoly.burakov@intel.com>, "Sivaprasad Tummala"
 <sivaprasad.tummala@amd.com>
Subject: Re: [PATCH] examples: Fix vm_power_manager scratch area to
 /run/dpdk/powermanager
Message-ID: <20260529082324.00a5f096@phoenix.local>
In-Reply-To: <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
References: <20260528190449.66254-1-giveback4fun@gmail.com>
 <ahlH3peE5oTV3qEz@bricha3-mobl1.ger.corp.intel.com>
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

On Fri, 29 May 2026 09:01:34 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Thu, May 28, 2026 at 07:04:48PM +0000, Sudheendra Sampath wrote:
> > This patch for bug 1832 will do the following:
> > 1.  If /run/dpdk is not present, it will create it first with and
> >     then create powermanager directory underneath it.
> > 2.  If /run/dpdk is present, it will verify it is actually a directory
> >     before creating subdirectory, powermanager.
> >   
> I would suggest using $XDG_RUNTIME_DIR for the directory path, rather than
> hardcoding it by default. If XDG_RUNTIME_DIR is not set, then maybe
> consider using /run/dpdk. However, rather than /run/dpdk, I'd suggest using
> the normal runtime dir path on most distros as the default:
> /run/user/<uid>.
> 
> /Bruce

The login in EAL is a little more detailed.
The choice is from systemd conventions which follows filesystem hierarchy.


int eal_create_runtime_dir(void)
{
	const char *directory;
	char run_dir[PATH_MAX];
	char tmp[PATH_MAX];
	int ret;

	/* from RuntimeDirectory= see systemd.exec */
	directory = getenv("RUNTIME_DIRECTORY");
	if (directory == NULL) {
		/*
		 * Used standard convention defined in
		 * XDG Base Directory Specification and
		 * Filesystem Hierarchy Standard.
		 */
		if (getuid() == 0)
			directory = "/var/run";
		else
			directory = getenv("XDG_RUNTIME_DIR") ? : "/tmp";
	}

	/* create DPDK subdirectory under runtime dir */
	ret = snprintf(tmp, sizeof(tmp), "%s/dpdk", directory);
	if (ret < 0 || ret == sizeof(tmp)) {
		EAL_LOG(ERR, "Error creating DPDK runtime path name");
		return -1;
	}

	/* create prefix-specific subdirectory under DPDK runtime dir */
	ret = snprintf(run_dir, sizeof(run_dir), "%s/%s",
			tmp, eal_get_hugefile_prefix());
	if (ret < 0 || ret == sizeof(run_dir)) {
		EAL_LOG(ERR, "Error creating prefix-specific runtime path name");
		return -1;
	}

	/* create the path if it doesn't exist. no "mkdir -p" here, so do it
	 * step by step.
	 */
	ret = mkdir(tmp, 0700);
	if (ret < 0 && errno != EEXIST) {
		EAL_LOG(ERR, "Error creating '%s': %s",
			tmp, strerror(errno));
		return -1;
	}

	ret = mkdir(run_dir, 0700);
	if (ret < 0 && errno != EEXIST) {
		EAL_LOG(ERR, "Error creating '%s': %s",
			run_dir, strerror(errno));
		return -1;
	}

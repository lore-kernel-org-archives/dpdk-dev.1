Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6294FCA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 14:45:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2ADF84025A;
	Thu, 28 Aug 2025 16:45:48 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 61F81400D6
 for <dev@dpdk.org>; Thu, 28 Aug 2025 16:45:46 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3cd59c5a953so676502f8f.0
 for <dev@dpdk.org>; Thu, 28 Aug 2025 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756392346;
 x=1756997146; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtM0ITmssz6BdTVgVZI1gj+gpm7ZUb9hQQJd9+G6j9Y=;
 b=Oy3r9NzKpH1Q9HPmjLCAlY6bPJS6/kgdPbMAGJ3XybSBPAp54NODZ2rZvuEQ8M7dY3
 7raj24McaCjh3nACqzR6/Vrmq+/05bPZ3H3THa9wthTkSnI9UBfbexwSAE2t0WrdI0EY
 lGuX4Y8PDtED4C4Aa7LBJCiUUT76tHNh3r+w5oanIjeqR3uDr5HMrxc/e/n6lfWwMyXl
 mxxejhcXyyMDRIbRJ+ayURs9uK829gjVzV6h7QmQLiClxZL5U84w6OWkdgu433VhMxdx
 KVZW90ZNiP37r9xUCCK1fvKE8k0YJFxdP1c4AAEjiFvutVIFSQ+z2jvXYTov/pvo7kQK
 fqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392346; x=1756997146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtM0ITmssz6BdTVgVZI1gj+gpm7ZUb9hQQJd9+G6j9Y=;
 b=RxJQbP4gClu1W7zkUtlIJb0Ciw6nZIICAn/cqLPzaJm1A4o+xzQr1nEGVV3OgX+OC7
 xtf16Iwdyorsm+40tt36AkASTbm2tIkM8oOCF5ZxSzg0Z90DDAvbm51adNejlDL34fCr
 8GgautY3MqA/m+jcFXyN7KiWjyuBrwbRcp/feCjeIHZbrIxxLHyo3sda7Jjdo3hHscz/
 w2Wg1qNVE+MW4o/awpEDa+1/1rH7Epm/mVmkyKScElEPuRwEhdvA1nGHCMDV1YJZkeC4
 aUk6RZg63mHyuxqq3Nkwo7gmjIkOT30SXR8LHHZrna+qEsWCle2/UkBbMEzFaBwB9ixh
 GPYA==
X-Gm-Message-State: AOJu0YwztKWE8oiHmrpNR/uaJCZJhtC83INVC9UXKJ9OyHQrd+cGkFFV
 ZFMj9jOzXng+FkG7+pX8K4aR4mVc4YLXMGU6EgnfkHFnOzry4vqKOhB9qA1rFyXDf14=
X-Gm-Gg: ASbGncsjqR8kHepB2Q2ML0lEdhRDSmN+USVxWIt5k5ESme/oT4/jW+OcXg3tE5YIH65
 cqAQaZBxt3j1s3+Pn8VNcfFxQYRedtEsHxAeNJevt8AmArNaAia2wcpePQK379xX/gzz/uvlp7e
 rulET+rFBg2W0lQ982MU8pkh15qRlqRYIOv8KeccO90oioUNmZZEEM3lAdoeXE+ZEBMo+0l2Dhl
 CCe7WvPzJ3aGtGf1lxnzbye0bDUnLUxh/QYdDLGFFqGJHBrw4TRgxwfrIaAUlAut4qfFm/rE+6Y
 e29gtSyxUAFkVPs7Xx564KiBDfIk6fzJA0Jo33wLFw2I5pbu29fmLNPOtNeWxqxoy4W4c9F4SBI
 PYsJN9I+iFDV2ex8ZNv8dioIJEhIIXNmomOkHQ5l+Z85J3Lyo4tSKEeKpF1hjju0M8LfSiqzL3Z
 Ab84kxSAULfQ==
X-Google-Smtp-Source: AGHT+IHVfebYNXpRx3Gw8StUyWmM7PmEN8eqjOPyp7546bfjcp1ILRD7ikZu3T/0PwMCL87z8J6LHA==
X-Received: by 2002:a05:6000:40df:b0:3c7:5844:333d with SMTP id
 ffacd0b85a97d-3c758443855mr15309070f8f.45.1756392345629; 
 Thu, 28 Aug 2025 07:45:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b73c52735sm57472345e9.22.2025.08.28.07.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 07:45:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 07:45:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Doraemon" <nobitanobi@qq.com>
Cc: "dev" <dev@dpdk.org>
Subject: Re: [Help needed] net_ice: MDD event (Malicious Driver Detection)
 on TX queue when using rte_eth_tx_prepare / rte_eth_tx_burst
Message-ID: <20250828074541.2996da5a@hermes.local>
In-Reply-To: <tencent_F6CFD7AE41985DA5FB835CDE833F44C6AF06@qq.com>
References: <tencent_F6CFD7AE41985DA5FB835CDE833F44C6AF06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 27 Aug 2025 08:52:26 +0800
"Doraemon" <nobitanobi@qq.com> wrote:

> Hello DPDK / net_ice maintainers,
>=20
>=20
> We are seeing a reproducible and concerning issue when using the net_ice =
PMD with DPDK 22.11.2, and we would appreciate your help diagnosing it.
>=20
>=20
> Summary
> - Environment:
> - DPDK: 22.11.2
> - net_ice PCI device: 8086:159b
> - ice kernel driver: 1.12.7
> - NIC firmware: FW 7.3.6111681 (NVM 4.30)
> - IOVA mode: PA, VFIO enabled
> - Multi-process socket: /var/run/dpdk/PGW/mp_socket
> - NUMA: 2, detected lcores: 112
> - Bonding: pmd_bond with bonded devices created (net_bonding0 on port 4, =
net_bonding1 on port 5)
> - Driver enabled AVX2 OFFLOAD Vector Tx (log shows "ice_set_tx_function()=
: Using AVX2 OFFLOAD Vector Tx")
>=20
>=20
> - Problem statement:
> - Our application calls rte_eth_tx_prepare before calling rte_eth_tx_burs=
t as part of the normal transmission path.
> - After the application has been running for some time (not immediate), t=
he kernel/driver emits the following messages repeatedly:
> - ice_interrupt_handler(): OICR: MDD event
> - ice_interrupt_handler(): Malicious Driver Detection event 3 by TCLAN on=
 TX queue 1025 PF# 1
> - We are using a single TX queue (application-level single queue) and are=
 sending only one packet per burst (burst size =3D 1).
> - The sequence is: rte_eth_tx_prepare (returns) -&gt; rte_eth_tx_burst -&=
gt; MDD events occur later.
> - The events affect stability and repeat over time.
>=20
>=20
> Relevant startup logs (excerpt)
> EAL: Detected CPU lcores: 112
> EAL: Detected NUMA nodes: 2
> EAL: Selected IOVA mode 'PA'
> EAL: VFIO support initialized
> EAL: Probe PCI driver: net_ice (8086:159b) device: 0000:3b:00.1 (socket 0)
> ice_load_pkg_type(): Active package is: 1.3.45.0, ICE COMMS Package (doub=
le VLAN mode)
> ice_dev_init(): FW 7.3.6111681 API 1.7
> ...
> bond_probe(3506) - Initializing pmd_bond for net_bonding0
> bond_probe(3592) - Create bonded device net_bonding0 on port 4 in mode 1 =
on socket 0.
> ...
> ice_set_tx_function(): Using AVX2 OFFLOAD Vector Tx (port 0).
> TELEMETRY: No legacy callbacks, legacy socket not created
>=20
>=20
> What we have tried / preliminary observations
> - Confirmed application calls rte_eth_tx_prepare prior to rte_eth_tx_burs=
t.
> - Confirmed single TX queue configuration and small bursts (size =3D 1) =
=E2=80=94 not high-rate, not a typical high-burst/malicious pattern.
> - The MDD log identifies "TX queue 1025";&nbsp; unclear how that maps to =
our DPDK queue numbering (we use queue 0 in the app).
> - No obvious other DPDK errors at startup;&nbsp; interface initializes no=
rmally and vector TX is enabled.
> - We suspect the driver's Malicious Driver Detection (MDD) is triggering =
due to some descriptor/doorbell ordering or offload interaction, possibly r=
elated to AVX2 Vector Tx offload.
>=20
>=20
> Questions / requests to the maintainers
> 1.&nbsp; What specifically triggers "MDD event 3 by TCLAN" in net_ice?&nb=
sp; Which driver check/threshold corresponds to event type 3?
> 2.&nbsp; How is the "TX queue 1025" value computed/mapped in the log?&nbs=
p; (Is it queue id + offset, VF mapping, or an internal vector id?)&nbsp; W=
e need to map that log value to our DPDK queue index.
> 3.&nbsp; Can the rte_eth_tx_prepare + rte_eth_tx_burst call pattern cause=
 MDD detections under any circumstances?&nbsp; If so, are there recommended=
 usage patterns or ordering constraints to avoid false positives?
> 4.&nbsp; Are there known firmware/driver/DPDK version combinations with s=
imilar MDD behavior?&nbsp; Do you recommend specific NIC firmware, kernel d=
river, or DPDK versions as a workaround/fix?
> 5.&nbsp; Any suggested workarounds we can test quickly (e.g., disable vec=
tor TX offload, disable specific HW offloads, change interrupt/queue bindin=
gs, or adjust doorbell behavior)?
>=20
>=20
>=20
>=20
> Best regards.

Did you make sure that the source address of the packet matches the MAC add=
ress of teh VF?

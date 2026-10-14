Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42521CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6420E4021E;
	Wed, 14 Oct 2026 17:00:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD93140144
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791990030;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=2mICydK9R4GIF+H9vvflO6y91koHUb+kglO38bLUlSs=;
 b=T7cnDYXpDvEX/x+FzwS6wx480lgkFVoppOGzTikcJgkCbE4CvY+G8hgHsNd1NnNmBaWXN1
 wdgIPYY7Ir7F5EI/5TAuOa/PqdbyQfB0m/e7wm7qdk8PCScnfTuqyL+RHRdjuY8n0LDSzD
 mP2WTe9VvJ5+/HGiIt7ZsKRlXk6bQKQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-z6e8n-8lOYGkxSBjnsT7xQ-1; Wed,
 14 Oct 2026 15:00:29 +0000
X-MC-Unique: z6e8n-8lOYGkxSBjnsT7xQ-1
X-Mimecast-MFC-AGG-ID: z6e8n-8lOYGkxSBjnsT7xQ_1791990027
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8220180067A; Wed, 14 Oct 2026 15:00:27 +0000 (UTC)
Received: from [100.90.45.206] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EC451800347; Wed, 14 Oct 2026 15:00:26 +0000 (UTC)
Message-ID: <ae11482f-c6e4-4213-acff-d4fdf0ed4324@redhat.com>
Date: Wed, 14 Oct 2026 17:00:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: DPDK security advisory: Multiple vulnerabilities in
 vhost/vhost-crypto/vDPA/GSO libraries
To: announce@dpdk.org, oss-security@lists.openwall.com
Cc: dev@dpdk.org, stable@dpdk.org
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -tADLOcKYkP3mO_IqrNQNHC8PCFH8MKF1egWemTtPvo_1791990027
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Reply-To: security@dpdk.org
Errors-To: dev-bounces@dpdk.org

Multiple vulnerabilities were fixed in DPDK.
Downstream stakeholders were warned in advance in order to coordinate 
the release of fixes and reduce the vulnerability window.

A malicious guest can exploit various memory safety issues in the DPDK 
vhost, vhost-crypto, vDPA, and GSO libraries to cause host crashes, 
denial of service, or potential memory corruption.
Some of these vulnerabilities affect the vhost-user boundary and can be 
triggered by a malicious VM.

Fixed in DPDK 23.11.8, 24.11.8, 25.11.4 LTS releases and main branch.

---

CVE-2026-86848 / CVE-2026-86846
Summary: vhost-crypto TOCTOU out-of-bounds write in finalize path
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2001
            https://bugs.dpdk.org/show_bug.cgi?id=2026
CVSS 3.1: 8.8 (High)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H
Note: CVE-2026-86846 is a duplicate issue with avail ring index, fixed 
in same patch.

---

CVE-2026-86561
Summary: Missing memory size validation before mmap in vhost memory 
region setup
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2002
CVSS 3.1: 6.5 (Medium)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:H

---

CVE-2026-86562
Summary: Double-fetch leading to heap buffer overflow in 
virtio_net_ctrl_pop (VDUSE)
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2003
            https://bugs.dpdk.org/show_bug.cgi?id=2021
CVSS 3.1: 7.8 (High)
CVSS:3.1/AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H

---

CVE-2026-86563
Summary: Double offset bug in vhost log mapping calculation
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2004
CVSS 3.1: 7.8 (High)
CVSS:3.1/AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:H/A:H

---

CVE-2026-86567
Summary: VDUSE vring stale pointer rebinding (use-after-unmap)
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2029
CVSS 3.1: 8.8 (High)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H

---

CVE-2026-86566
Summary: Copy length underflow in vhost enqueue (mbuf_to_desc)
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2020
CVSS 3.1: 6.5 (Medium)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:H

---

CVE-2026-86849
Summary: Integer overflow and missing validation in vhost-crypto request 
handling
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2022
CVSS 3.1: 6.5 (Medium)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:H


---

CVE-2026-86845
Summary: Use-after-free and type confusion in vhost-crypto session handling
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2028
CVSS 3.1: 6.5 (Medium)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:H


---

CVE-2026-86847
Summary: Infinite cleanup loop in vhost-crypto writeback chain
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2023
CVSS 3.1: 6.5 (Medium)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:H


---

CVE-2026-86856
Summary: Stack and heap buffer overflow in nfp vDPA driver
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2027
CVSS 3.1: 6.5 (Medium)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:N/A:H


---

CVE-2026-86564
Summary: Out-of-bounds heap read in vhost control virtqueue handler
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2007
CVSS 3.1: 3.3 (Low)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:N/I:N/A:L


---

CVE-2026-86565
Summary: Split-ring inflight descriptor table overflow
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2008
CVSS 3.1: 8.8 (High)
CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:H/I:H/A:H


---

CVE-2026-93683
Summary: Indirect descriptor table double-fetch (TOCTOU)
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2046
CVSS 3.1: 6.4 (Medium)
CVSS:3.1/AV:L/AC:H/PR:L/UI:N/S:C/C:H/I:N/A:L


---

CVE-2026-100236
Summary: GSO library heap out-of-bounds read/write with small mbuf pools
Bugzilla: https://bugs.dpdk.org/show_bug.cgi?id=2047
CVSS 3.1: 8.6 (High)
CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:L/A:H

---

Acknowledgments:

The DPDK project thanks the following security researchers for 
responsibly reporting these vulnerabilities:

- Adiel Sol (Dream Group) - CVE-2026-86848
- Ivar Al-Safawi - CVE-2026-86561, CVE-2026-86562, CVE-2026-86563, 
CVE-2026-86567
- Jia Jia - CVE-2026-86565
- Arthur Chan (Adalogics) - CVE-2026-86566, CVE-2026-86849, 
CVE-2026-86845, CVE-2026-86846, CVE-2026-86847, CVE-2026-86856
- syber steve - CVE-2026-86564
- Naseeb Dangi and Xiang Li from AOSP Lab aty Nankai Universit - 
CVE-2026-93683

---

For more information on DPDK security, see:
https://doc.dpdk.org/guides/contributing/vulnerability.html



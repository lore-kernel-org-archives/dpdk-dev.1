Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C407FC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:33:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF413427C3;
	Wed,  4 Jun 2025 13:33:21 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 6810E4029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749036791;
 bh=Hjr0XbO/ojJw0nJu2dHawW6RJJudiS3hOQ1CIPsGNWM=;
 h=From:To:Cc:Subject:Date;
 b=C7nXPHmWZcvbpXvj6XvSOgyI1yl3aT4A33K1CJdl/9tA2+T1y+uMROiT2jYJmdsTk
 1zjmAo2BBZNOuVaN4e3m44bD5SNJMB4eSY4gom1Z9ch8U9u43HsqWUqh6jI5lBvhNd
 J6iGjl4SF7fwBBK//Rn9ncQS99o6+Ngoy+P9gPBo=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
 id 849B1A74; Wed, 04 Jun 2025 19:33:09 +0800
X-QQ-mid: xmsmtpt1749036789ta56g5vuz
Message-ID: <tencent_90C4C220787E54EF2CC686B28BC7E604B109@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uluhqroXs7S+6+fj0H9Iewes9Fgr0kK/sKD/QV3JQKYc1jK4oM9
 tcERkcIwJ4sevKobY0fm0+10PEXhDO2Oq8ys4qAqrPDN8fA2MsoNiuwkHTSI2ycWrz12F1GD/VhH
 01cuQ9TT0bEekTTBC+Td1omHqgpPwYNNNnpxwYLXg+Sx+/zup1M7spNHngqczY54Usu9t/xiK/N9
 vOU+LutWdwtSXfAUFpVZJ5jNN763kctErzGg3FSlMJs4JRQGNQb2ev9g0I2UwkzCVx7GLXhEWtj0
 JkAN3ULuQSt30wOrGJNTmH5LMJLaaDFVDsAt2v3+JGn1rZJVf5rrg/wm/tS/cfKxVMs9BDlwj+fC
 CAZnivxLltfKbpAlIZi29S6/vfUYWv9ToazYPSrrmggJXell511cZQc83nSkImgWRDzZxuAxfYGh
 xgLoIPqKtsw4DV3m+qxHM8qDRw2OYnPyIB2WkhuNdHpQsUD6qjV7bj8aThldVpR/ebCaC60J9mcM
 swin/54SOpMosKfX45Z2lM8KUojOfBV2+S1kkPBDnR/wtF1Le3jlFzWNwdthPZ4+4gDpDCG4efPe
 XZ5IHptcZHE3o+AUeaPj6IyykYuCeyZOsk0GQhZlXHb52m+4L5NYanHeMaDkvY6GFIyS0qYu3Y6L
 fKpwBaaJCIOIworQoL63JfaRGwxBc5ld3EUJlY5i47KCEoGkvNWiKAVUWj9IfR4CT8fkwSQFYEYV
 SOIkgR7JgqMdKXMNMxobt1pw5fAC7AHd+wf9nCjeQHOd1OFpZVEVLHRI1FpXw80CDZWnMRVy0SXB
 CRcgKcVB3dNSY8OAVrNpBX/VLv4kvd1fJkGmlwCWjj0+jZcRaWsts9Avmz5b2BvDtzkbqXU59dNF
 QLPwh34ACT1EUz7jFAik7glCOvgOECeuulnzHzuqd1Hbk5uX/5XRohuZmpAu8KZxhuy7SIPyPNct
 aID3y51upGRQ291dFueQfrq5/K8vjKtczP5DYftsu9Uyfwjrv8zwdt+HLp/ijTFCwSkHptblFPBp
 fdEf0ntI9H0RfteWBy
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH v2 0/3] Add RISC-V V extension detection and LPM optimization
Date: Wed,  4 Jun 2025 19:31:23 +0800
X-OQ-MSGID: <20250604113123.1866595-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: sunyuechi <sunyuechi@iscas.ac.cn>

This patch series adds support for the RISC-V Vector (V) extension and provides
an optimized implementation of `rte_lpm_lookupx4` using RVV. It includes runtime
detection of the V extension, conditional compilation based on compiler support
for RVV intrinsics.

Test results using lpm_perf_autotest on BPI-F3:
    scalar: 5.7 cycles
    rvv:    2.4 cycles

### v2:
- Improved commit messages.

sunyuechi (3):
  config/riscv: detect V extension
  lib/lpm: R-V V rte_lpm_lookupx4
  riscv: override machine_args only when default

 MAINTAINERS              |  2 +
 config/riscv/meson.build | 27 ++++++++++++
 lib/lpm/meson.build      |  1 +
 lib/lpm/rte_lpm.h        |  2 +
 lib/lpm/rte_lpm_rvv.h    | 91 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

--
2.49.0


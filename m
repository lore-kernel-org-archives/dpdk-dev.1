Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A5C79FA1
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 05:00:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 607F240269;
	Fri, 11 Sep 2026 07:00:42 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id ABECE40264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 07:00:41 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6411C20014C
 for <dev@dpdk.org>; Fri, 11 Sep 2026 07:00:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CD83200106
 for <dev@dpdk.org>; Fri, 11 Sep 2026 07:00:41 +0200 (CEST)
Received: from [92.120.147.87] (wsv03115.swis.in-blr01.nxp.com [92.120.147.87])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7915618000B1
 for <dev@dpdk.org>; Fri, 11 Sep 2026 13:00:40 +0800 (+08)
Content-Type: multipart/alternative;
 boundary="------------o67wbenyfhAqOCIOPx5oJ3Nn"
Message-ID: <e947ff33-8dc3-4e3d-b6e7-16f295af6b50@oss.nxp.com>
Date: Fri, 11 Sep 2026 10:30:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] bus/fslmc: fix signed comparison in buffer acquire
To: dev@dpdk.org
References: <20260904191652.2399074-1-stephen@networkplumber.org>
 <20260904191652.2399074-3-stephen@networkplumber.org>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <20260904191652.2399074-3-stephen@networkplumber.org>
X-Virus-Scanned: ClamAV using ClamSMTP
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

This is a multi-part message in MIME format.
--------------o67wbenyfhAqOCIOPx5oJ3Nn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>return -EINVAL;

--------------o67wbenyfhAqOCIOPx5oJ3Nn
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Acked-by: Hemant Agrawal <a class="moz-txt-link-rfc2396E" href="mailto:hemant.agrawal@nxp.com">&lt;hemant.agrawal@nxp.com&gt;</a><span
      style="white-space: pre-wrap"> 		return -EINVAL;</span></p>
  </body>
</html>

--------------o67wbenyfhAqOCIOPx5oJ3Nn--

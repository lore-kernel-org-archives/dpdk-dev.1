Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE36CA5FCB
	for <dpdk-dev@archiver.kernel.org>; Thu,  1 Oct 2026 13:27:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1B9040144;
	Thu,  1 Oct 2026 15:27:24 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013037.outbound.protection.outlook.com
 [40.107.162.37])
 by mails.dpdk.org (Postfix) with ESMTP id B787B400D5;
 Thu,  1 Oct 2026 15:03:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hexOrtOBcChZrhjBy4+0//GFovzEHAuX3362SeV8hOKYZhuuQw3LmRWUdum2a+u9EgQlGgPr0CmyaHe6O2fZylINgaCx6AUlIQiijgX8MU1Idy4CFJVSzR97APvkCH6jQH2ZRnqwrj2ArR8t6wNGkVuFA2TzYkWoQRw2ZCKLVjIFjwkUYhmdfIS0Kxi+0BbGCI1a8cKKX9h+QEUwjsRfh8ssZ55e48w9qRax72nZScSY8sBc2WQ7D4Hv38pVPacECYEX4tsJkqe8Bf9KQFIMoilb1yaj/cOfCzr5ypCiX5OPCyeqI1cEuQuVe7vbNVgjrWpzDQ+Mo9ahvdosxaa49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGkLjbJ7JA0ac0LeAlGotu1lBTZiiuPbfcpKXLVpXw0=;
 b=INSeyiAr//yi6RYYGwUUMAd0qaVZYwzgbfqyqvj+rdzrleqegfSgZfz9cU2Z0PaOrZj02QMrcGa3dfUG3wBcj/TGkMAv4PWuD2LM+7frJbN1Ey1GSxvJgVX9GJKV/ZNKoXsrOI+8tOfrEzCfztuk7URIIj1lp8IhVYr98ZvWr5mU0yoV/X/vrROEVLYpJv/TZzcKxQS1Wm834KS6h52XRYGgz3c0vXGvhU8vStUOHNaWE0MradtxozEw2m+5ggvNx8LpAAGvWw1NX+duvcdKQJlnwUsJATixh0ZuWA3GeNA64ddqBywGQMsuTWTk5kXS5gddmQPa3jIlPp3i4TCT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGkLjbJ7JA0ac0LeAlGotu1lBTZiiuPbfcpKXLVpXw0=;
 b=Yd6jsz+F2Ez+ZHqWQ4W101lCjog4eyZJdGEwvlMSy6NtuuCFExAE6JCkNXoVEyUZ+xHqlA2uw2AomhZgfcQpUmOv/WRgvK1mgfXtHHUah8eamQpXuoGIke/doG8vKt8NNhLoNf7BhCdj8SbcsyoMFpA6V+FfKQU6wu0/29humI6xng4tMlVp9l4Kj+1DGEFgg5zYowcMynJ6wzeiHlB/CWmhXay9KEZQVaJ0rXAvmjiTqn/AvqSbHwXjjl4hKnsi4lkEzHMuAGsGpv2BU8bLIA5K7hh8j/FLN+sTI9sDYOwevyW+kaWtMjDE/yvRDV2697AsPeyAA8lG+NDmqQCLGw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM9PR07MB7732.eurprd07.prod.outlook.com (2603:10a6:20b:306::18)
 by PA1PR07MB11484.eurprd07.prod.outlook.com (2603:10a6:102:554::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 13:03:06 +0000
Received: from AM9PR07MB7732.eurprd07.prod.outlook.com
 ([fe80::e39:d971:f3f0:a4c8]) by AM9PR07MB7732.eurprd07.prod.outlook.com
 ([fe80::e39:d971:f3f0:a4c8%3]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 13:03:06 +0000
From: Thanushree Sreerama <thanushree.sreerama@nokia.com>
To: Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Nipun Gupta <nipun.gupta@amd.com>
Cc: David Marchand <david.marchand@redhat.com>, jpf@zurich.ibm.com,
 Thanushree Sreerama <thanushree.sreerama@nokia.com>, dev@dpdk.org,
 stable@dpdk.org
Subject: [PATCH v2] bus/pci: retry VFIO device reset on EAGAIN
Date: Thu,  1 Oct 2026 15:03:02 +0200
Message-ID: <20261001130302.4097-1-thanushree.sreerama@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
References: <20250903111723.5111-1-thanushree.sreerama@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To AM9PR07MB7732.eurprd07.prod.outlook.com
 (2603:10a6:20b:306::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR07MB7732:EE_|PA1PR07MB11484:EE_
X-MS-Office365-Filtering-Correlation-Id: 515ce5a5-a33f-40dd-dabb-08df1fbc557b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VVkRs9vDvEjSyHz8dFgVEXpB5IXlqDY5k7D+IpSdXU7p77BS2j7jl829XD+sE076eLPVkxRbecn+JE7ge0i+izTAJ7q0Lc8karTTI7sJGhBo0FAsJ5W0hR4QJxY9FI6dIovbZCMQO0lKItEqcoN/XWfwB31ksECkMIShidtoTSWDsPXr+qPwM+RQ2Gvl82guAF8e6PBnYMLFL82TcXJ7tZfxOGlSLr9S+7h9VMqmZJr6RDn7Elij0IG3jdzrF1slCIZ7DdpWqDSRblldCzCMmAqDln0Z+kp/uhcx+9jY/UofLGLGk0h/rxxK8F+aZH8z322QN/3FX0uS1qlBqUz8vSFQHE1ZAseXnmXk+s5TLJuAklwcwhj91Zu+74QFV6HgAJVXtnkPm7CJe5o+jFgAwTeG51DfBDNuysWSoW1nI4VFqvwMLxso10LOKsHSpqtnp4OU6jrAUJZufISjtnhXCnhFoyrdh5SZOJuHKifLqQCVhCWaSF+VOArjT1hpU76xYeAwuhxQwPb8E6BxiseKeT1QG3Ldm+/mDWXYCKSu2AlLFXcvaRYw5wXQIuTc5SCIMx0Pqy5ZNdSpk2JJm0wOe9n0PQQ2oKU3hmBN/G5MEEbTT6EFAPrI+OaTk6vtl431HzNAazu+TPMoibGTu0JakFW/FZHDRXgQJCODY2Wliw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR07MB7732.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oc/YWiO4DiKyC+4Qesv9lGQB+MP6x6ydAjti2NNsyU0V1XQPaZ3HizFz0W1q?=
 =?us-ascii?Q?J8sv8WK9PKO1i43dweh9SIoT1+4yRaA7qo3fIGRjoZn8jHcyNvq8E4VuzJmq?=
 =?us-ascii?Q?djrhNhQrM027siHP/tlcvx0waXFRx9eUH5NlSlBwhUZmUsFpvaEu31bPXX94?=
 =?us-ascii?Q?UBBevzLa6AE3FFI3xupGnvGKIt6teX5XvGm7FOra5y6CiE6hCxc7XraaT4jQ?=
 =?us-ascii?Q?B6+eoaxxzduo9ez/ZLtcbvdHx9DMxIY79Wjo1H+EYjjswubBaZ44QGIwlZkd?=
 =?us-ascii?Q?BMbS2cw+D9CsKxxMTvKBTkuLKO3MiTkra4IfWpwaALokxnr+JD832/HA6Hlr?=
 =?us-ascii?Q?8++D5KgG1X3+TG7wlEotUVUGCZj0woB5cBhoGZBORSyqlkEqVVSNvikmMwFJ?=
 =?us-ascii?Q?KwbQVCbkTw7BjdtpIQ16k2aaPxrmlOxZ5OC+FUkAbZUejPKCSSRaKSxM5rhb?=
 =?us-ascii?Q?poMAoJVgZc8GAplrH3Eh+VNbTv1OGSBROc7j5adeweADCXtomqwCIaV8i7SC?=
 =?us-ascii?Q?zg8QGwIUdbwo4m8u7W2AwMTttosp2MNmpN3kPUxMoiVh4gpkyoAIgU/yRmik?=
 =?us-ascii?Q?cjS208SF8sB08Ap/+SbUOUHUYUTIjWSio2ginhSZIpPV9fbEkcfBcisS5sX/?=
 =?us-ascii?Q?9p5qHBRJwOppVhxRQlUMGcll+xjblEPloR3obdXKgDFweXWUszVmzLGn2Olr?=
 =?us-ascii?Q?YlLMuzvFQiXOudRMJRS/e7w16AYlnZL+UoFSZ7agz5OYiQgehvJ84ETv8l34?=
 =?us-ascii?Q?fUUI3hIwFizM3QpkpoL++oBIat+ivXWe9nYt/uNPNns/8NUWtE60bRFCNnOU?=
 =?us-ascii?Q?7lqIbwzTCMUssthATCsgmZdKUI5OxnPh/EwHO7U8KvHbTYgTh39wLhUHekkw?=
 =?us-ascii?Q?aqyklSH/O+JqyqERiEiBZXI1V90nPyB74wH7FkH+h0KMu/KR0DsIbx//54ez?=
 =?us-ascii?Q?wBiLTfGjDsBNuPc1aoJYpXt6GiXeDGPOXzS4t57dI6s0fo01iGaeMmQh9pXe?=
 =?us-ascii?Q?K3NY1wMu/z85usMq+ag9CQf0XyhCMwIMiD5Q4ZOMQMNwnkHjmNzN/uiVoXnp?=
 =?us-ascii?Q?ZXJFHRqOiVyRmyx5asl57RUC4A/Q8H23hVbWFNI2t1VVhGqy3t+F81LoMgW8?=
 =?us-ascii?Q?1SrI/z9sCw8FlPvS8w5Slp0NXku7he4USv6F9uv/4mdBD3DZK9h48am4Xlpw?=
 =?us-ascii?Q?lKMIPS7VkamVbiZf5YyHLo4wX4+JHJ0ZjwtBiD5NU1zmoArjXrqKqpEmeDGs?=
 =?us-ascii?Q?/8Kq1BTm5UUC3g7JvnG2D/elAIets/Zm+Q5ktCFMBpxaTrhDAfMd4RX8KmZK?=
 =?us-ascii?Q?G97Cq7gMC7LMHcyfLKvhbw4u87CMI1Kri2cSW+StBiAOA/1mXl9Ob+iN7Xlk?=
 =?us-ascii?Q?fbck7CU36MUuc3PxBhBR8PHR7bTPgheVHUUOqk5z1YG+V0B5PTP+60j640Tp?=
 =?us-ascii?Q?n06PuDKcl7AHu0fhLuTUXFhJ6tyOqz/0R8pNLQ7dJrYqFHlex6/yNWdctN7Q?=
 =?us-ascii?Q?BbLT2NtzV4Oiab9QLzVhue8DNLijyLh7UKChoiZAFOMy9KoRWFb8jnFqBskS?=
 =?us-ascii?Q?uKYjEFTAPqXihLKbwD5012oqrUW8I3/1qMZLCyKUIkTktasCkiFfX2ePiA/a?=
 =?us-ascii?Q?U+rVcDNcgvQCJAneTiTXG27ZVdM39qf9tJ5Ux7RwmSM0B4tPr7BK3u1I57cg?=
 =?us-ascii?Q?mQ/vZYZTJknTfJzFFq6HN3WtSAy3MY7OaGs16+rLkpBEt+eeTTZPovipHRwP?=
 =?us-ascii?Q?nzsgioaevvUTuf3+kRia/qrMA6CdAkY=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515ce5a5-a33f-40dd-dabb-08df1fbc557b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR07MB7732.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:03:06.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdU5brm4qIzyq7qf1/9Hn8lHOwBgd6Ppb2F82PRZuVltgyj45sojgD2N7Yft86tIlZ7AhWw4N0BO7tCNOYo3rGYS0D4NrUSOn19ygHiR5Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB11484
X-Mailman-Approved-At: Thu, 01 Oct 2026 15:27:24 +0200
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

VFIO_DEVICE_RESET is implemented in the kernel with
pci_try_reset_function(), which uses pci_dev_trylock() and returns
-EAGAIN when the PCI device lock is already held.

That lock is taken by other kernel paths, in particular sysfs
uevent_show(). After Linux restored device_lock() in uevent_show()
(revert of "driver core: Fix uevent_show() vs driver detach race"),
udev or any reader of /sys/.../uevent can race with DPDK VFIO
setup, and the ioctl returns errno 11 (EAGAIN).

Without a retry, pci_rte_vfio_setup_device() fails, EAL skips the
PCI device, and the application cannot use it:

  EAL: Unable to reset device! Error: 11 (Resource temporarily unavailable)
  EAL: 0000:f4:02.3 setup device failed
  EAL: Requested device 0000:f4:02.3 cannot be used

The device lock is held only for the sysfs/uevent critical section,
typically well under 20 ms. Retry the ioctl up to 5 times with a
20 ms delay (100 ms in total). That was enough for the transient
failure we observed; a persistent EAGAIN still fails device setup.

Fixes: f25f8f367644 ("bus/pci: check VFIO reset ioctl error")
Cc: stable@dpdk.org

Signed-off-by: Thanushree Sreerama <thanushree.sreerama@nokia.com>
---
Cc: jpf@zurich.ibm.com
Cc: Anatoly Burakov <anatoly.burakov@intel.com>

Changes since v1:
- Rebased on main
- Drop Change-Id
- Document EAGAIN condition, functional impact, and retry values
- Fail setup if retries are exhausted
- Match pci_vfio.c declaration style

 drivers/bus/pci/linux/pci_vfio.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index bc5c5c249..3ec5af8ed 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -420,6 +420,10 @@ pci_vfio_is_ioport_bar(const struct rte_pci_device *dev, int vfio_dev_fd,
 static int
 pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
 {
+	const int max_retries = 5;
+	const int retry_delay_ms = 20;
+	int i, ret;
+
 	if (pci_vfio_setup_interrupts(dev, vfio_dev_fd) != 0) {
 		PCI_LOG(ERR, "Error setting up interrupts!");
 		return -1;
@@ -439,12 +443,20 @@ pci_rte_vfio_setup_device(struct rte_pci_device *dev, int vfio_dev_fd)
 	 * Reset the device. If the device is not capable of resetting,
 	 * then it updates errno as EINVAL.
 	 */
-	if (ioctl(vfio_dev_fd, VFIO_DEVICE_RESET) && errno != EINVAL) {
-		PCI_LOG(ERR, "Unable to reset device! Error: %d (%s)", errno, strerror(errno));
-		return -1;
+	for (i = 0; i < max_retries; i++) {
+		errno = 0;
+		ret = ioctl(vfio_dev_fd, VFIO_DEVICE_RESET);
+		if (ret == 0 || errno == EINVAL)
+			return 0;
+		if (errno != EAGAIN || i + 1 == max_retries)
+			break;
+		PCI_LOG(DEBUG, "Device reset EAGAIN, retry %d/%d after %d ms",
+			i + 1, max_retries, retry_delay_ms);
+		usleep(retry_delay_ms * 1000);
 	}
 
-	return 0;
+	PCI_LOG(ERR, "Unable to reset device! Error: %d (%s)", errno, strerror(errno));
+	return -1;
 }
 
 static int
-- 
2.45.0


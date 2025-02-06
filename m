Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1BC02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 09:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 874F9402CE;
	Thu,  6 Feb 2025 10:41:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 584534026C
 for <dev@dpdk.org>; Thu,  6 Feb 2025 10:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738834869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GPTMjapWwV27Uv4d5GnE6Pd/y5m1K5oboVbtM2ICPbY=;
 b=bKUICGTgrwlDmcCHck1FR3B75bnTs7HVKOT97p36LvP8de8JHfmeXHT5iXD1zMuF3OnGEW
 YBOW30O8iw2CEmo2avetqFefvZVxKbA5ZCSiLrifJBJVKs0AN2+ev8qMlnQMa4yQYmHetL
 3vRK4GmjtKV5OstUry6lJZrJE5aV9zA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-rS7S-9S2PPe7xtR8DaZA7g-1; Thu,
 06 Feb 2025 04:41:04 -0500
X-MC-Unique: rS7S-9S2PPe7xtR8DaZA7g-1
X-Mimecast-MFC-AGG-ID: rS7S-9S2PPe7xtR8DaZA7g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14F3419560BB; Thu,  6 Feb 2025 09:41:03 +0000 (UTC)
Received: from [10.45.242.4] (unknown [10.45.242.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 733111800352; Thu,  6 Feb 2025 09:40:59 +0000 (UTC)
Message-ID: <4a529276-2d23-4486-873b-ecba155b78f6@redhat.com>
Date: Thu, 6 Feb 2025 10:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/4] common/virtio: move vDPA to common directory
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, dev@dpdk.org,
 Akhil Goyal <gakhil@marvell.com>, Chenbo Xia <chenbox@nvidia.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Jay Zhou <jianjay.zhou@huawei.com>
Cc: jerinj@marvell.com, anoobj@marvell.com,
 David Marchand <david.marchand@redhat.com>
References: <cover.1736270269.git.gmuthukrishn@marvell.com>
 <0951d143cd811aa8389a0c1eaf2cd70fe315f3f4.1736270269.git.gmuthukrishn@marvell.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <0951d143cd811aa8389a0c1eaf2cd70fe315f3f4.1736270269.git.gmuthukrishn@marvell.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RU_GxUx2rRLkutgrhAtvlKBWzN9EQtdcRdhvB_449io_1738834863
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
Errors-To: dev-bounces@dpdk.org

Hi Gowrishankar,

On 1/7/25 7:44 PM, Gowrishankar Muthukrishnan wrote:
> Move vhost-vdpa backend implementation into common folder.

If we decided to have a common base for Virtio devices, which I think is
a good idea to avoid needless duplication, we should do a deeper
refactoring by sharing all transport layers: PCI and Virtio-user.

I understand it is not realistic to do this for v25.03 release, so in
the mean time I prefer you duplicate what you need from Vhost-vDPA
implementation than having an half-baked solution.

Maintainers, what do you think?

Thanks,
Maxime

> Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
> ---
> Depends-on: patch-149672 ("vhost: include AKCIPHER algorithms in crypto_config")
> Depends-on: patch-148913 ("crypto/virtio: remove redundant crypto queue free")
> Depends-on: series-34293 ("crypto/virtio: add packed ring support")
> Depends-on: series-34291 ("crypto/virtio: add RSA support")
> 
> 
>   drivers/common/virtio/meson.build             | 13 +++++++++
>   drivers/common/virtio/version.map             |  8 ++++++
>   .../virtio/virtio_user/vhost.h                |  4 ---
>   .../common/virtio/virtio_user/vhost_logs.h    | 15 ++++++++++
>   .../virtio/virtio_user/vhost_vdpa.c           | 28 ++++++++++++++++++-
>   drivers/crypto/virtio/meson.build             |  2 +-
>   drivers/meson.build                           |  1 +
>   drivers/net/virtio/meson.build                |  3 +-
>   drivers/net/virtio/virtio_user/vhost_kernel.c |  3 +-
>   drivers/net/virtio/virtio_user/vhost_user.c   |  3 +-
>   .../net/virtio/virtio_user/virtio_user_dev.c  |  5 ++--
>   .../net/virtio/virtio_user/virtio_user_dev.h  | 24 +++++++++-------
>   12 files changed, 87 insertions(+), 22 deletions(-)
>   create mode 100644 drivers/common/virtio/meson.build
>   create mode 100644 drivers/common/virtio/version.map
>   rename drivers/{net => common}/virtio/virtio_user/vhost.h (97%)
>   create mode 100644 drivers/common/virtio/virtio_user/vhost_logs.h
>   rename drivers/{net => common}/virtio/virtio_user/vhost_vdpa.c (97%)
> 
> diff --git a/drivers/common/virtio/meson.build b/drivers/common/virtio/meson.build
> new file mode 100644
> index 0000000000..a19db9e088
> --- /dev/null
> +++ b/drivers/common/virtio/meson.build
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Marvell
> +
> +if is_windows
> +    build = false
> +    reason = 'not supported on Windows'
> +    subdir_done()
> +endif
> +
> +if is_linux
> +    sources += files('virtio_user/vhost_vdpa.c')
> +    deps += ['bus_vdev']
> +endif
> diff --git a/drivers/common/virtio/version.map b/drivers/common/virtio/version.map
> new file mode 100644
> index 0000000000..fb98a0ab2e
> --- /dev/null
> +++ b/drivers/common/virtio/version.map
> @@ -0,0 +1,8 @@
> +INTERNAL {
> +	global:
> +
> +	virtio_ops_vdpa;
> +	vhost_logtype_driver;
> +
> +	local: *;
> +};
> diff --git a/drivers/net/virtio/virtio_user/vhost.h b/drivers/common/virtio/virtio_user/vhost.h
> similarity index 97%
> rename from drivers/net/virtio/virtio_user/vhost.h
> rename to drivers/common/virtio/virtio_user/vhost.h
> index eee3a4bc47..adf6551681 100644
> --- a/drivers/net/virtio/virtio_user/vhost.h
> +++ b/drivers/common/virtio/virtio_user/vhost.h
> @@ -11,10 +11,6 @@
>   
>   #include <rte_errno.h>
>   
> -#include "../virtio.h"
> -#include "../virtio_logs.h"
> -#include "../virtqueue.h"
> -
>   struct vhost_vring_state {
>   	unsigned int index;
>   	unsigned int num;
> diff --git a/drivers/common/virtio/virtio_user/vhost_logs.h b/drivers/common/virtio/virtio_user/vhost_logs.h
> new file mode 100644
> index 0000000000..653d4d0b5e
> --- /dev/null
> +++ b/drivers/common/virtio/virtio_user/vhost_logs.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Marvell
> + */
> +
> +#ifndef _VHOST_LOGS_H_
> +#define _VHOST_LOGS_H_
> +
> +#include <rte_log.h>
> +
> +extern int vhost_logtype_driver;
> +#define RTE_LOGTYPE_VHOST_DRIVER vhost_logtype_driver
> +#define PMD_DRV_LOG(level, ...) \
> +	RTE_LOG_LINE_PREFIX(level, VHOST_DRIVER, "%s(): ", __func__, __VA_ARGS__)
> +
> +#endif /* _VHOST_LOGS_H_ */
> diff --git a/drivers/net/virtio/virtio_user/vhost_vdpa.c b/drivers/common/virtio/virtio_user/vhost_vdpa.c
> similarity index 97%
> rename from drivers/net/virtio/virtio_user/vhost_vdpa.c
> rename to drivers/common/virtio/virtio_user/vhost_vdpa.c
> index bc3e2a9af5..af5c4cbf33 100644
> --- a/drivers/net/virtio/virtio_user/vhost_vdpa.c
> +++ b/drivers/common/virtio/virtio_user/vhost_vdpa.c
> @@ -9,11 +9,12 @@
>   #include <fcntl.h>
>   #include <stdlib.h>
>   #include <unistd.h>
> +#include <inttypes.h>
>   
>   #include <rte_memory.h>
>   
>   #include "vhost.h"
> -#include "virtio_user_dev.h"
> +#include "vhost_logs.h"
>   
>   struct vhost_vdpa_data {
>   	int vhostfd;
> @@ -100,6 +101,29 @@ vhost_vdpa_ioctl(int fd, uint64_t request, void *arg)
>   	return 0;
>   }
>   
> +struct virtio_hw {
> +	struct virtqueue **vqs;
> +};
> +
> +struct virtio_user_dev {
> +	union {
> +		struct virtio_hw hw;
> +		uint8_t dummy[256];
> +	};
> +
> +	void		*backend_data;
> +	uint16_t	**notify_area;
> +	char		path[PATH_MAX];
> +	bool		hw_cvq;
> +	uint16_t	max_queue_pairs;
> +	uint64_t	device_features;
> +	bool		*qp_enabled;
> +};
> +
> +#define VIRTIO_NET_F_CTRL_VQ   17
> +#define VIRTIO_F_IOMMU_PLATFORM        33
> +#define VIRTIO_ID_NETWORK  0x01
> +
>   static int
>   vhost_vdpa_set_owner(struct virtio_user_dev *dev)
>   {
> @@ -715,3 +739,5 @@ struct virtio_user_backend_ops virtio_ops_vdpa = {
>   	.map_notification_area = vhost_vdpa_map_notification_area,
>   	.unmap_notification_area = vhost_vdpa_unmap_notification_area,
>   };
> +
> +RTE_LOG_REGISTER_SUFFIX(vhost_logtype_driver, driver, NOTICE);
> diff --git a/drivers/crypto/virtio/meson.build b/drivers/crypto/virtio/meson.build
> index d2c3b3ad07..8181c8296f 100644
> --- a/drivers/crypto/virtio/meson.build
> +++ b/drivers/crypto/virtio/meson.build
> @@ -8,7 +8,7 @@ if is_windows
>   endif
>   
>   includes += include_directories('../../../lib/vhost')
> -deps += 'bus_pci'
> +deps += ['bus_pci', 'common_virtio']
>   sources = files(
>           'virtio_cryptodev.c',
>           'virtio_cvq.c',
> diff --git a/drivers/meson.build b/drivers/meson.build
> index 495e21b54a..2f0d312479 100644
> --- a/drivers/meson.build
> +++ b/drivers/meson.build
> @@ -17,6 +17,7 @@ subdirs = [
>           'common/nitrox',  # depends on bus.
>           'common/qat',     # depends on bus.
>           'common/sfc_efx', # depends on bus.
> +        'common/virtio',  # depends on bus.
>           'mempool',        # depends on common and bus.
>           'dma',            # depends on common and bus.
>           'net',            # depends on common, bus, mempool
> diff --git a/drivers/net/virtio/meson.build b/drivers/net/virtio/meson.build
> index 02742da5c2..bbd73741f0 100644
> --- a/drivers/net/virtio/meson.build
> +++ b/drivers/net/virtio/meson.build
> @@ -54,7 +54,6 @@ if is_linux
>           'virtio_user/vhost_kernel.c',
>           'virtio_user/vhost_kernel_tap.c',
>           'virtio_user/vhost_user.c',
> -        'virtio_user/vhost_vdpa.c',
>           'virtio_user/virtio_user_dev.c')
> -    deps += ['bus_vdev']
> +    deps += ['bus_vdev', 'common_virtio']
>   endif
> diff --git a/drivers/net/virtio/virtio_user/vhost_kernel.c b/drivers/net/virtio/virtio_user/vhost_kernel.c
> index e42bb35935..3a95ce34d6 100644
> --- a/drivers/net/virtio/virtio_user/vhost_kernel.c
> +++ b/drivers/net/virtio/virtio_user/vhost_kernel.c
> @@ -11,9 +11,10 @@
>   
>   #include <rte_memory.h>
>   
> -#include "vhost.h"
> +#include "virtio_user/vhost.h"
>   #include "virtio_user_dev.h"
>   #include "vhost_kernel_tap.h"
> +#include "../virtqueue.h"
>   
>   struct vhost_kernel_data {
>   	int *vhostfds;
> diff --git a/drivers/net/virtio/virtio_user/vhost_user.c b/drivers/net/virtio/virtio_user/vhost_user.c
> index c10252506b..2a158aff7e 100644
> --- a/drivers/net/virtio/virtio_user/vhost_user.c
> +++ b/drivers/net/virtio/virtio_user/vhost_user.c
> @@ -16,7 +16,8 @@
>   #include <rte_string_fns.h>
>   #include <rte_fbarray.h>
>   
> -#include "vhost.h"
> +#include "virtio_user/vhost_logs.h"
> +#include "virtio_user/vhost.h"
>   #include "virtio_user_dev.h"
>   
>   struct vhost_user_data {
> diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> index 2997d2bd26..7105c54b43 100644
> --- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
> +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
> @@ -20,10 +20,11 @@
>   #include <rte_malloc.h>
>   #include <rte_io.h>
>   
> -#include "vhost.h"
> -#include "virtio.h"
> +#include "virtio_user/vhost.h"
>   #include "virtio_user_dev.h"
> +#include "../virtqueue.h"
>   #include "../virtio_ethdev.h"
> +#include "../virtio_logs.h"
>   
>   #define VIRTIO_USER_MEM_EVENT_CLB_NAME "virtio_user_mem_event_clb"
>   
> diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.h b/drivers/net/virtio/virtio_user/virtio_user_dev.h
> index 66400b3b62..70604d6956 100644
> --- a/drivers/net/virtio/virtio_user/virtio_user_dev.h
> +++ b/drivers/net/virtio/virtio_user/virtio_user_dev.h
> @@ -25,26 +25,36 @@ struct virtio_user_queue {
>   };
>   
>   struct virtio_user_dev {
> -	struct virtio_hw hw;
> +	union {
> +		struct virtio_hw hw;
> +		uint8_t dummy[256];
> +	};
> +
> +	void		*backend_data;
> +	uint16_t	**notify_area;
> +	char		path[PATH_MAX];
> +	bool		hw_cvq;
> +	uint16_t	max_queue_pairs;
> +	uint64_t	device_features; /* supported features by device */
> +	bool		*qp_enabled;
> +
>   	enum virtio_user_backend_type backend_type;
>   	bool		is_server;  /* server or client mode */
>   
>   	int		*callfds;
>   	int		*kickfds;
>   	int		mac_specified;
> -	uint16_t	max_queue_pairs;
> +
>   	uint16_t	queue_pairs;
>   	uint32_t	queue_size;
>   	uint64_t	features; /* the negotiated features with driver,
>   				   * and will be sync with device
>   				   */
> -	uint64_t	device_features; /* supported features by device */
>   	uint64_t	frontend_features; /* enabled frontend features */
>   	uint64_t	unsupported_features; /* unsupported features mask */
>   	uint8_t		status;
>   	uint16_t	net_status;
>   	uint8_t		mac_addr[RTE_ETHER_ADDR_LEN];
> -	char		path[PATH_MAX];
>   	char		*ifname;
>   
>   	union {
> @@ -54,18 +64,12 @@ struct virtio_user_dev {
>   	} vrings;
>   
>   	struct virtio_user_queue *packed_queues;
> -	bool		*qp_enabled;
>   
>   	struct virtio_user_backend_ops *ops;
>   	pthread_mutex_t	mutex;
>   	bool		started;
>   
> -	bool			hw_cvq;
>   	struct virtqueue	*scvq;
> -
> -	void *backend_data;
> -
> -	uint16_t **notify_area;
>   };
>   
>   int virtio_user_dev_set_features(struct virtio_user_dev *dev);


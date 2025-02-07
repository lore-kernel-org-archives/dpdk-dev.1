Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223C8C02192
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:40:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57C91427B5;
	Fri,  7 Feb 2025 09:40:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 36F75427A7
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:40:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Zz3+tVzGEx1JFsv4UM4ifqgVHqlaDfM5JFXs6EmnnqM=;
 b=EVOD/RWTBeTlxTYRXWxNJeATcTbDQiuOz8qhlreSGcOQYJzb/4PzlVWpaZObd7UyKMT7uD
 4J5fLTqPH41c0qJ5aW/V8i6vHycP40UbO5DBsE2yDX3+0/mIejBkG4UCwhoRXe7BWh3ubD
 ylNCixq+W6MR4vs2hFYkGGTj9GnNuyM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-6rnWNWMGPkmCxMJgatnx7A-1; Fri,
 07 Feb 2025 03:40:23 -0500
X-MC-Unique: 6rnWNWMGPkmCxMJgatnx7A-1
X-Mimecast-MFC-AGG-ID: 6rnWNWMGPkmCxMJgatnx7A
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 000BD1955D4F; Fri,  7 Feb 2025 08:40:22 +0000 (UTC)
Received: from [10.44.22.21] (unknown [10.44.22.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8FB61800360; Fri,  7 Feb 2025 08:40:19 +0000 (UTC)
Message-ID: <c76eda50-adf7-4620-994c-df46b0201cf4@redhat.com>
Date: Fri, 7 Feb 2025 09:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] bbdev: add trace point
To: Nicolas Chautru <nicolas.chautru@intel.com>, dev@dpdk.org
Cc: hemant.agrawal@nxp.com, hernan.vargas@intel.com
References: <20250123225519.2469167-1-nicolas.chautru@intel.com>
 <20250123225519.2469167-2-nicolas.chautru@intel.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20250123225519.2469167-2-nicolas.chautru@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fIuWHlz4QB4ftiJKBF-lb28xlyXliiOSAisfUvRO4PI_1738917622
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



On 1/23/25 11:55 PM, Nicolas Chautru wrote:
> Adds trace points for rte_bbdev.
> 
> Signed-off-by: Nicolas Chautru <nicolas.chautru@intel.com>
> ---
>   lib/bbdev/bbdev_trace.h        | 69 ++++++++++++++++++++++++++++++++++
>   lib/bbdev/bbdev_trace_points.c | 27 +++++++++++++
>   lib/bbdev/meson.build          |  6 ++-
>   lib/bbdev/rte_bbdev.c          | 17 +++++++++
>   lib/bbdev/rte_bbdev.h          | 50 +++++++++++++++++++++---
>   lib/bbdev/rte_bbdev_trace_fp.h | 41 ++++++++++++++++++++
>   lib/bbdev/version.map          |  4 ++
>   7 files changed, 206 insertions(+), 8 deletions(-)
>   create mode 100644 lib/bbdev/bbdev_trace.h
>   create mode 100644 lib/bbdev/bbdev_trace_points.c
>   create mode 100644 lib/bbdev/rte_bbdev_trace_fp.h
> 
> diff --git a/lib/bbdev/bbdev_trace.h b/lib/bbdev/bbdev_trace.h
> new file mode 100644
> index 0000000000..7256d6b703
> --- /dev/null
> +++ b/lib/bbdev/bbdev_trace.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Intel Corporation
> + */
> +
> +#ifndef BBDEV_TRACE_H
> +#define BBDEV_TRACE_H
> +
> +/**
> + * @file
> + *
> + * API for bbdev trace support
> + */
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <rte_trace_point.h>
> +
> +#include "rte_bbdev.h"
> +
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_setup_queues,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t num_queues, int socket_id),
> +	rte_trace_point_emit_u8(dev_id);
> +	rte_trace_point_emit_u16(num_queues);
> +	rte_trace_point_emit_int(socket_id);
> +)
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_queue_configure,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t queue_id, const char *op_str, uint8_t pri),
> +	rte_trace_point_emit_u8(dev_id);
> +	rte_trace_point_emit_u16(queue_id);
> +	rte_trace_point_emit_string(op_str);
> +	rte_trace_point_emit_u8(pri);
> +)
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_start,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id),
> +	rte_trace_point_emit_u8(dev_id);
> +)
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_stop,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id),
> +	rte_trace_point_emit_u8(dev_id);
> +)
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_close,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id),
> +	rte_trace_point_emit_u8(dev_id);
> +)
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_queue_start,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t queue_id),
> +	rte_trace_point_emit_u8(dev_id);
> +	rte_trace_point_emit_u16(queue_id);
> +)
> +RTE_TRACE_POINT(
> +	rte_bbdev_trace_queue_stop,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t queue_id),
> +	rte_trace_point_emit_u8(dev_id);
> +	rte_trace_point_emit_u16(queue_id);
> +)
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* BBDEV_TRACE_H */
> diff --git a/lib/bbdev/bbdev_trace_points.c b/lib/bbdev/bbdev_trace_points.c
> new file mode 100644
> index 0000000000..6f90e2aa65
> --- /dev/null
> +++ b/lib/bbdev/bbdev_trace_points.c
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Intel Corporation
> + */
> +
> +#include <rte_trace_point_register.h>
> +
> +#include "bbdev_trace.h"
> +
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_setup_queues,
> +	lib.bbdev.queue.setup)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_configure,
> +	lib.bbdev.queue.configure)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_start,
> +	lib.bbdev.start)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_stop,
> +	lib.bbdev.stop)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_close,
> +	lib.bbdev.close)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_start,
> +	lib.bbdev.queue.start)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_queue_stop,
> +	lib.bbdev.queue.stop)
> +
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_enqueue,
> +	lib.bbdev.enq)
> +RTE_TRACE_POINT_REGISTER(rte_bbdev_trace_dequeue,
> +	lib.bbdev.deq)
> diff --git a/lib/bbdev/meson.build b/lib/bbdev/meson.build
> index 07685e7578..d8b95a400e 100644
> --- a/lib/bbdev/meson.build
> +++ b/lib/bbdev/meson.build
> @@ -7,8 +7,10 @@ if is_windows
>       subdir_done()
>   endif
>   
> -sources = files('rte_bbdev.c')
> +sources = files('rte_bbdev.c',
> +        'bbdev_trace_points.c')
>   headers = files('rte_bbdev.h',
>           'rte_bbdev_pmd.h',
> -        'rte_bbdev_op.h')
> +        'rte_bbdev_op.h',
> +        'rte_bbdev_trace_fp.h')
>   deps += ['mbuf']
> diff --git a/lib/bbdev/rte_bbdev.c b/lib/bbdev/rte_bbdev.c
> index bd32da79b0..d7901cd29d 100644
> --- a/lib/bbdev/rte_bbdev.c
> +++ b/lib/bbdev/rte_bbdev.c
> @@ -20,6 +20,7 @@
>   #include "rte_bbdev_op.h"
>   #include "rte_bbdev.h"
>   #include "rte_bbdev_pmd.h"
> +#include "bbdev_trace.h"
>   
>   #define DEV_NAME "BBDEV"
>   
> @@ -321,6 +322,8 @@ rte_bbdev_setup_queues(uint16_t dev_id, uint16_t num_queues, int socket_id)
>   
>   	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
>   
> +	rte_bbdev_trace_setup_queues(dev_id, num_queues, socket_id);
> +
>   	if (dev->data->started) {
>   		rte_bbdev_log(ERR,
>   				"Device %u cannot be configured when started",
> @@ -436,6 +439,10 @@ int
>   rte_bbdev_queue_configure(uint16_t dev_id, uint16_t queue_id,
>   		const struct rte_bbdev_queue_conf *conf)
>   {
> +
> +	rte_bbdev_trace_queue_configure(dev_id, queue_id, rte_bbdev_op_type_str(conf->op_type),
> +			conf->priority);
> +
>   	int ret = 0;
>   	struct rte_bbdev_driver_info dev_info;
>   	struct rte_bbdev *dev = get_dev(dev_id);
> @@ -557,6 +564,8 @@ rte_bbdev_start(uint16_t dev_id)
>   
>   	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
>   
> +	rte_bbdev_trace_start(dev_id);
> +
>   	if (dev->data->started) {
>   		rte_bbdev_log_debug("Device %u is already started", dev_id);
>   		return 0;
> @@ -588,6 +597,8 @@ rte_bbdev_stop(uint16_t dev_id)
>   
>   	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
>   
> +	rte_bbdev_trace_stop(dev_id);
> +
>   	if (!dev->data->started) {
>   		rte_bbdev_log_debug("Device %u is already stopped", dev_id);
>   		return 0;
> @@ -611,6 +622,8 @@ rte_bbdev_close(uint16_t dev_id)
>   
>   	VALID_DEV_OPS_OR_RET_ERR(dev, dev_id);
>   
> +	rte_bbdev_trace_close(dev_id);
> +
>   	if (dev->data->started) {
>   		ret = rte_bbdev_stop(dev_id);
>   		if (ret < 0) {
> @@ -656,6 +669,8 @@ rte_bbdev_queue_start(uint16_t dev_id, uint16_t queue_id)
>   
>   	VALID_QUEUE_OR_RET_ERR(queue_id, dev);
>   
> +	rte_bbdev_trace_queue_start(dev_id, queue_id);
> +
>   	if (dev->data->queues[queue_id].started) {
>   		rte_bbdev_log_debug("Queue %u of device %u already started",
>   				queue_id, dev_id);
> @@ -686,6 +701,8 @@ rte_bbdev_queue_stop(uint16_t dev_id, uint16_t queue_id)
>   
>   	VALID_QUEUE_OR_RET_ERR(queue_id, dev);
>   
> +	rte_bbdev_trace_queue_stop(dev_id, queue_id);
> +
>   	if (!dev->data->queues[queue_id].started) {
>   		rte_bbdev_log_debug("Queue %u of device %u already stopped",
>   				queue_id, dev_id);
> diff --git a/lib/bbdev/rte_bbdev.h b/lib/bbdev/rte_bbdev.h
> index 6d5cdc7b8c..710280f0df 100644
> --- a/lib/bbdev/rte_bbdev.h
> +++ b/lib/bbdev/rte_bbdev.h
> @@ -32,6 +32,8 @@
>   extern "C" {
>   #endif
>   
> +#include "rte_bbdev_trace_fp.h"
> +
>   #ifndef RTE_BBDEV_MAX_DEVS
>   #define RTE_BBDEV_MAX_DEVS 128  /**< Max number of devices */
>   #endif
> @@ -569,6 +571,8 @@ rte_bbdev_enqueue_enc_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> +	rte_bbdev_trace_enqueue(dev_id, queue_id, (void **)ops, num_ops,
> +			rte_bbdev_op_type_str(RTE_BBDEV_OP_TURBO_DEC));
>   	return dev->enqueue_enc_ops(q_data, ops, num_ops);
>   }
>   
> @@ -599,6 +603,8 @@ rte_bbdev_enqueue_dec_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> +	rte_bbdev_trace_enqueue(dev_id, queue_id, (void **)ops, num_ops,
> +			rte_bbdev_op_type_str(RTE_BBDEV_OP_TURBO_ENC));
>   	return dev->enqueue_dec_ops(q_data, ops, num_ops);
>   }
>   
> @@ -629,6 +635,8 @@ rte_bbdev_enqueue_ldpc_enc_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> +	rte_bbdev_trace_enqueue(dev_id, queue_id, (void **)ops, num_ops,
> +			rte_bbdev_op_type_str(RTE_BBDEV_OP_LDPC_ENC));
>   	return dev->enqueue_ldpc_enc_ops(q_data, ops, num_ops);
>   }
>   
> @@ -659,6 +667,8 @@ rte_bbdev_enqueue_ldpc_dec_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> +	rte_bbdev_trace_enqueue(dev_id, queue_id, (void **)ops, num_ops,
> +			rte_bbdev_op_type_str(RTE_BBDEV_OP_LDPC_DEC));
>   	return dev->enqueue_ldpc_dec_ops(q_data, ops, num_ops);
>   }
>   
> @@ -689,6 +699,8 @@ rte_bbdev_enqueue_fft_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> +	rte_bbdev_trace_enqueue(dev_id, queue_id, (void **)ops, num_ops,
> +			rte_bbdev_op_type_str(RTE_BBDEV_OP_FFT));
>   	return dev->enqueue_fft_ops(q_data, ops, num_ops);
>   }
>   
> @@ -719,6 +731,8 @@ rte_bbdev_enqueue_mldts_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> +	rte_bbdev_trace_enqueue(dev_id, queue_id, (void **)ops, num_ops,
> +			rte_bbdev_op_type_str(RTE_BBDEV_OP_MLDTS));
>   	return dev->enqueue_mldts_ops(q_data, ops, num_ops);
>   }
>   
> @@ -750,7 +764,11 @@ rte_bbdev_dequeue_enc_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> -	return dev->dequeue_enc_ops(q_data, ops, num_ops);
> +	uint16_t num_ops_dequeued = dev->dequeue_enc_ops(q_data, ops, num_ops);
> +	if (num_ops_dequeued > 0)
> +		rte_bbdev_trace_dequeue(dev_id, queue_id, (void **)ops, num_ops,
> +				num_ops_dequeued, rte_bbdev_op_type_str(RTE_BBDEV_OP_TURBO_ENC));
> +	return num_ops_dequeued;
>   }
>   
>   /**
> @@ -782,7 +800,11 @@ rte_bbdev_dequeue_dec_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> -	return dev->dequeue_dec_ops(q_data, ops, num_ops);
> +	uint16_t num_ops_dequeued = dev->dequeue_dec_ops(q_data, ops, num_ops);
> +	if (num_ops_dequeued > 0)
> +		rte_bbdev_trace_dequeue(dev_id, queue_id, (void **)ops, num_ops,
> +				num_ops_dequeued, rte_bbdev_op_type_str(RTE_BBDEV_OP_TURBO_DEC));
> +	return num_ops_dequeued;
>   }
>   
>   
> @@ -813,7 +835,11 @@ rte_bbdev_dequeue_ldpc_enc_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> -	return dev->dequeue_ldpc_enc_ops(q_data, ops, num_ops);
> +	uint16_t num_ops_dequeued = dev->dequeue_ldpc_enc_ops(q_data, ops, num_ops);
> +	if (num_ops_dequeued > 0)
> +		rte_bbdev_trace_dequeue(dev_id, queue_id, (void **)ops, num_ops,
> +				num_ops_dequeued, rte_bbdev_op_type_str(RTE_BBDEV_OP_LDPC_ENC));
> +	return num_ops_dequeued;
>   }
>   
>   /**
> @@ -843,7 +869,11 @@ rte_bbdev_dequeue_ldpc_dec_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> -	return dev->dequeue_ldpc_dec_ops(q_data, ops, num_ops);
> +	uint16_t num_ops_dequeued = dev->dequeue_ldpc_dec_ops(q_data, ops, num_ops);
> +	if (num_ops_dequeued > 0)
> +		rte_bbdev_trace_dequeue(dev_id, queue_id, (void **)ops, num_ops,
> +				num_ops_dequeued, rte_bbdev_op_type_str(RTE_BBDEV_OP_LDPC_DEC));
> +	return num_ops_dequeued;
>   }
>   
>   /**
> @@ -873,7 +903,11 @@ rte_bbdev_dequeue_fft_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> -	return dev->dequeue_fft_ops(q_data, ops, num_ops);
> +	uint16_t num_ops_dequeued = dev->dequeue_fft_ops(q_data, ops, num_ops);
> +	if (num_ops_dequeued > 0)
> +		rte_bbdev_trace_dequeue(dev_id, queue_id, (void **)ops, num_ops,
> +				num_ops_dequeued, rte_bbdev_op_type_str(RTE_BBDEV_OP_FFT));
> +	return num_ops_dequeued;
>   }
>   
>   /**
> @@ -903,7 +937,11 @@ rte_bbdev_dequeue_mldts_ops(uint16_t dev_id, uint16_t queue_id,
>   {
>   	struct rte_bbdev *dev = &rte_bbdev_devices[dev_id];
>   	struct rte_bbdev_queue_data *q_data = &dev->data->queues[queue_id];
> -	return dev->dequeue_mldts_ops(q_data, ops, num_ops);
> +	uint16_t num_ops_dequeued = dev->dequeue_mldts_ops(q_data, ops, num_ops);
> +	if (num_ops_dequeued > 0)
> +		rte_bbdev_trace_dequeue(dev_id, queue_id, (void **)ops, num_ops,
> +				num_ops_dequeued, rte_bbdev_op_type_str(RTE_BBDEV_OP_MLDTS));
> +	return num_ops_dequeued;
>   }
>   
>   /** Definitions of device event types */
> diff --git a/lib/bbdev/rte_bbdev_trace_fp.h b/lib/bbdev/rte_bbdev_trace_fp.h
> new file mode 100644
> index 0000000000..d8b2217d17
> --- /dev/null
> +++ b/lib/bbdev/rte_bbdev_trace_fp.h
> @@ -0,0 +1,41 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(C) 2025 Intel Corporation
> + */
> +
> +#ifndef _RTE_BBDEV_TRACE_FP_H_
> +#define _RTE_BBDEV_TRACE_FP_H_
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#include <rte_trace_point.h>
> +
> +RTE_TRACE_POINT_FP(
> +	rte_bbdev_trace_enqueue,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t qp_id, void **ops,
> +		uint16_t nb_ops, const char *op_string),
> +	rte_trace_point_emit_u8(dev_id);
> +	rte_trace_point_emit_u16(qp_id);
> +	rte_trace_point_emit_ptr(ops);
> +	rte_trace_point_emit_u16(nb_ops);
> +	rte_trace_point_emit_string(op_string);
> +)
> +
> +RTE_TRACE_POINT_FP(
> +	rte_bbdev_trace_dequeue,
> +	RTE_TRACE_POINT_ARGS(uint8_t dev_id, uint16_t qp_id, void **ops,
> +		uint16_t nb_ops, uint16_t nb_ops_deq, const char *op_string),
> +	rte_trace_point_emit_u8(dev_id);
> +	rte_trace_point_emit_u16(qp_id);
> +	rte_trace_point_emit_ptr(ops);
> +	rte_trace_point_emit_u16(nb_ops);
> +	rte_trace_point_emit_u16(nb_ops_deq);
> +	rte_trace_point_emit_string(op_string);
> +)
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_BBDEV_TRACE_FP_H_ */
> diff --git a/lib/bbdev/version.map b/lib/bbdev/version.map
> index 1e11485b17..b9b4f31e33 100644
> --- a/lib/bbdev/version.map
> +++ b/lib/bbdev/version.map
> @@ -40,4 +40,8 @@ EXPERIMENTAL {
>   	# added in 24.11
>   	rte_bbdev_queue_ops_dump;
>   	rte_bbdev_ops_param_string;
> +
> +	# added in 25.03
> +	__rte_bbdev_trace_dequeue;
> +	__rte_bbdev_trace_enqueue;
>   };

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime

